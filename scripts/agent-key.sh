#!/bin/bash
#
# Grant or revoke agent-key SSH access on servers.
#
# Connects using your normal SSH config (admin/security keys) and edits the
# remote authorized_keys. Hosts are SSH aliases or user@host targets.
#
# Usage:
#   agent-key.sh add <host> [host...]
#   agent-key.sh remove <host> [host...]
#   agent-key.sh status <host> [host...]
#
# Examples:
#   agent-key.sh add erp-walayar erp-kallekkad erp-palathurai
#   agent-key.sh remove erp-walayar
#   agent-key.sh status nas-ultra erp-southern

set -euo pipefail

PUB_KEY_FILE="$HOME/.ssh/keys/agent-key.pub"

usage() {
    sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'
    exit 1
}

[ $# -ge 2 ] || usage
ACTION="$1"
shift

case "$ACTION" in
    add|remove|status) ;;
    *) usage ;;
esac

if [ ! -f "$PUB_KEY_FILE" ]; then
    echo "ERROR: public key not found: $PUB_KEY_FILE" >&2
    exit 1
fi

PUB_KEY="$(cat "$PUB_KEY_FILE")"
# Key material (type + base64 blob) identifies the key even if the comment differs.
KEY_BLOB="$(echo "$PUB_KEY" | awk '{print $1" "$2}')"

FAILED=0

for host in "$@"; do
    case "$ACTION" in
        add)
            if ssh -o ConnectTimeout=10 "$host" "
                set -eu
                mkdir -p ~/.ssh && chmod 700 ~/.ssh
                touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
                if grep -qF '$KEY_BLOB' ~/.ssh/authorized_keys; then
                    echo 'already present'
                else
                    echo '$PUB_KEY' >> ~/.ssh/authorized_keys
                    echo 'added'
                fi
            " 2>/dev/null | sed "s/^/$host: /"; then
                :
            else
                echo "$host: ERROR: could not connect or update" >&2
                FAILED=1
            fi
            ;;
        remove)
            if ssh -o ConnectTimeout=10 "$host" "
                set -eu
                if [ ! -f ~/.ssh/authorized_keys ]; then
                    echo 'no authorized_keys file'
                elif grep -qF '$KEY_BLOB' ~/.ssh/authorized_keys; then
                    grep -vF '$KEY_BLOB' ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp || true
                    chmod 600 ~/.ssh/authorized_keys.tmp
                    mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys
                    echo 'removed'
                else
                    echo 'not present'
                fi
            " 2>/dev/null | sed "s/^/$host: /"; then
                :
            else
                echo "$host: ERROR: could not connect or update" >&2
                FAILED=1
            fi
            ;;
        status)
            if result=$(ssh -o ConnectTimeout=10 "$host" "
                grep -qF '$KEY_BLOB' ~/.ssh/authorized_keys 2>/dev/null && echo present || echo absent
            " 2>/dev/null); then
                echo "$host: $result"
            else
                echo "$host: ERROR: could not connect" >&2
                FAILED=1
            fi
            ;;
    esac
done

exit "$FAILED"
