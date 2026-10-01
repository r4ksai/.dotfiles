#!/usr/bin/env bash
# Export a time range of footage from a Hikvision NVR (ISAPI search/download,
# falling back to RTSP playback via ffmpeg). Generalized from
# export_camera1_2026-07-06.sh to take host/camera/time-range as parameters.
set -euo pipefail

usage() {
  cat >&2 <<'USAGE'
Usage: export_nvr_footage.sh --start "YYYY-MM-DD HH:MM:SS" --end "YYYY-MM-DD HH:MM:SS" [options]

Required:
  --start TIME       Start time, local NVR time, e.g. "2026-07-06 18:15:00"
  --end   TIME        End time, local NVR time, e.g. "2026-07-06 19:09:00"

Options:
  --host HOST          NVR IP or hostname (env: NVR_HOST, default: 10.1.1.51)
  --base URL            Full NVR base URL, overrides --host (env: NVR_BASE, default: http://<host>)
  --user USER            NVR username (env: NVR_USER; preferred over --pass so it
                            doesn't show up in `ps`)
  --pass PASS            NVR password (env: NVR_PASS; prefer the env var)
  --camera N              Camera number, e.g. 1 (default: 1)
  --track ID              RTSP track ID, overrides the camera-number default of
                            "<camera>01" (Hikvision main-stream convention)
  --tz OFFSET             NVR timezone offset, e.g. +05:30 (default: +05:30)
  --out FILE               Output filename (default: auto-generated from
                            camera/date/time)
  --no-checksum             Skip writing an OUT.sha256 file
  -h, --help                Show this help

Credentials can also be supplied via NVR_USER / NVR_PASS environment
variables, e.g.:

  NVR_USER=admin NVR_PASS='secret' ./export_nvr_footage.sh \
    --host 10.1.1.51 --camera 1 \
    --start "2026-07-06 18:15:00" --end "2026-07-06 19:09:00"
USAGE
  exit "${1:-2}"
}

NVR_HOST="${NVR_HOST:-10.1.1.51}"
NVR_BASE="${NVR_BASE:-}"
NVR_USER="${NVR_USER:-}"
NVR_PASS="${NVR_PASS:-}"
CAMERA="1"
TRACK_ID=""
TZ_OFFSET="+05:30"
START=""
END=""
OUT=""
WRITE_CHECKSUM=1

while [[ $# -gt 0 ]]; do
  case "$1" in
    --host) NVR_HOST="$2"; shift 2 ;;
    --base) NVR_BASE="$2"; shift 2 ;;
    --user) NVR_USER="$2"; shift 2 ;;
    --pass) NVR_PASS="$2"; shift 2 ;;
    --camera) CAMERA="$2"; shift 2 ;;
    --track) TRACK_ID="$2"; shift 2 ;;
    --tz) TZ_OFFSET="$2"; shift 2 ;;
    --start) START="$2"; shift 2 ;;
    --end) END="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    --no-checksum) WRITE_CHECKSUM=0; shift ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown option: $1" >&2; usage 2 ;;
  esac
done

[[ -n "$NVR_BASE" ]] || NVR_BASE="http://${NVR_HOST}"
[[ -n "$TRACK_ID" ]] || TRACK_ID="${CAMERA}01"

if [[ -z "$NVR_USER" || -z "$NVR_PASS" ]]; then
  echo "Set NVR_USER and NVR_PASS (env vars preferred), then rerun." >&2
  usage 2
fi

if [[ -z "$START" || -z "$END" ]]; then
  echo "Both --start and --end are required." >&2
  usage 2
fi

# Parse "YYYY-MM-DD HH:MM:SS" as if it were UTC to get a "naive" epoch, then
# shift by the timezone offset to get the true UTC epoch. Avoids relying on
# BSD date's unreliable %z handling for colon-separated offsets like +05:30.
naive_epoch() {
  date -j -u -f "%Y-%m-%d %H:%M:%S" "$1" "+%s"
}

offset_seconds() {
  local off="$1" sign=1
  [[ "$off" == -* ]] && sign=-1
  off="${off#[+-]}"
  local hh="${off%%:*}" mm="${off##*:}"
  echo $(( sign * (10#$hh * 3600 + 10#$mm * 60) ))
}

off_secs="$(offset_seconds "$TZ_OFFSET")"
start_epoch=$(( $(naive_epoch "$START") - off_secs ))
end_epoch=$(( $(naive_epoch "$END") - off_secs ))

if (( end_epoch <= start_epoch )); then
  echo "End time must be after start time." >&2
  exit 2
fi

duration=$(( end_epoch - start_epoch ))
duration_hms="$(printf '%02d:%02d:%02d' $((duration/3600)) $((duration%3600/60)) $((duration%60)))"

START_RTSP="$(date -u -r "$start_epoch" "+%Y%m%dT%H%M%SZ")"
END_RTSP="$(date -u -r "$end_epoch" "+%Y%m%dT%H%M%SZ")"

date_part="${START%% *}"
time_part="${START#* }"
START_LOCAL="${date_part}T${time_part}${TZ_OFFSET}"
END_date_part="${END%% *}"
END_time_part="${END#* }"
END_LOCAL="${END_date_part}T${END_time_part}${TZ_OFFSET}"

if [[ -z "$OUT" ]]; then
  compact_date="${date_part//-/}"
  start_hm="${time_part%%:*}${time_part#*:}"; start_hm="${start_hm%:*}"
  end_hm="${END_time_part%%:*}${END_time_part#*:}"; end_hm="${end_hm%:*}"
  OUT="camera${CAMERA}_${compact_date}_${start_hm}-${end_hm}.mp4"
fi

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

search_xml="$tmpdir/search.xml"
search_result="$tmpdir/search-result.xml"
download_xml="$tmpdir/download.xml"
http_out="$tmpdir/http-download.bin"

cat > "$search_xml" <<XML
<?xml version="1.0" encoding="UTF-8"?>
<CMSearchDescription>
  <searchID>camera${CAMERA}-${compact_date:-$(date -u +%Y%m%d)}</searchID>
  <trackList>
    <trackID>${TRACK_ID}</trackID>
  </trackList>
  <timeSpanList>
    <timeSpan>
      <startTime>${START_LOCAL}</startTime>
      <endTime>${END_LOCAL}</endTime>
    </timeSpan>
  </timeSpanList>
  <maxResults>40</maxResults>
  <searchResultPostion>0</searchResultPostion>
  <metadataList>
    <metadataDescriptor>//recordType.meta.std-cgi.com</metadataDescriptor>
  </metadataList>
</CMSearchDescription>
XML

echo "Searching NVR recordings on track ${TRACK_ID} (${START_LOCAL} to ${END_LOCAL})..."
if curl --fail --silent --show-error --anyauth \
  --user "$NVR_USER:$NVR_PASS" \
  --header "Content-Type: application/xml" \
  --data-binary "@$search_xml" \
  "${NVR_BASE}/ISAPI/ContentMgmt/search" \
  > "$search_result"; then

  playback_uri="$(python3 - "$search_result" <<'PY'
import sys
import xml.etree.ElementTree as ET

path = sys.argv[1]
root = ET.parse(path).getroot()
for elem in root.iter():
    if elem.tag.split('}', 1)[-1] == 'playbackURI' and elem.text:
        print(elem.text.strip())
        break
PY
)"

  if [[ -n "$playback_uri" ]]; then
    cat > "$download_xml" <<XML
<?xml version="1.0" encoding="UTF-8"?>
<downloadRequest>
  <playbackURI>${playback_uri}</playbackURI>
</downloadRequest>
XML

    echo "Trying HTTP export..."
    if curl --fail --location --anyauth \
      --user "$NVR_USER:$NVR_PASS" \
      --header "Content-Type: application/xml" \
      --data-binary "@$download_xml" \
      "${NVR_BASE}/ISAPI/ContentMgmt/download" \
      --output "$http_out"; then
      mv "$http_out" "$OUT"
      echo "Saved $OUT"
      if [[ "$WRITE_CHECKSUM" -eq 1 ]]; then
        shasum -a 256 "$OUT" > "${OUT%.mp4}.sha256"
        echo "Wrote ${OUT%.mp4}.sha256"
      fi
      exit 0
    fi
    echo "HTTP export failed; falling back to RTSP playback."
  else
    echo "No playbackURI found in search response; falling back to RTSP playback."
  fi
else
  echo "ISAPI search failed; falling back to RTSP playback."
fi

rtsp_url="rtsp://${NVR_USER}:${NVR_PASS}@${NVR_HOST}:554/Streaming/tracks/${TRACK_ID}?starttime=${START_RTSP}&endtime=${END_RTSP}"

echo "Exporting via ffmpeg RTSP (duration ${duration_hms})..."
ffmpeg -hide_banner -y -rtsp_transport tcp -i "$rtsp_url" \
  -t "$duration_hms" \
  -map 0 \
  -c:v copy \
  -c:a aac \
  -b:a 64k \
  -movflags +faststart \
  "$OUT"
echo "Saved $OUT"

if [[ "$WRITE_CHECKSUM" -eq 1 ]]; then
  shasum -a 256 "$OUT" > "${OUT%.mp4}.sha256"
  echo "Wrote ${OUT%.mp4}.sha256"
fi
