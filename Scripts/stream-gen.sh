#!/bin/bash

# Function to display usage
usage() {
	echo "Usage: $0 -u <username> -p <password> -i <ip_address> -c <channel> [-P <port>] [-s <stream>]"
	echo " -u: Username for Hikvision"
	echo " -p: Password for Hikvision"
	echo " -i: IP address of the Hikvision camera"
	echo " -c: Channel number (usually 1)"
	echo " -P: Port number (optional, default 554 for RTSP)"
	echo " -s: Stream type (optional, default is 'main')"
	echo "     'main' for main stream"
	echo "     'sub' for sub stream"
	echo "     'third' for third stream"
	exit 1
}

url_encode() {
	local encoded=""
	local length="${#1}"
	for ((i = 0; i < length; i++)); do
		local c="${1:i:1}"
		case $c in
		[a-zA-Z0-9.~_-])
			encoded+="$c"
			;;
		*)
			printf -v encoded "%s%%%02X" "$encoded" "'$c"
			;;
		esac
	done
	echo "$encoded"
}

# Default values
PORT=554
STREAM="main"

# Parse command-line arguments
while getopts "u:p:i:c:P:s:" opt; do
	case $opt in
	u) USERNAME="$OPTARG" ;;
	p) PASSWORD="$OPTARG" ;;
	i) IP_ADDRESS="$OPTARG" ;;
	c) CHANNEL="$OPTARG" ;;
	P) PORT="$OPTARG" ;;
	s) STREAM="$OPTARG" ;;
	*) usage ;;
	esac
done

# Check for mandatory parameters
if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ] || [ -z "$IP_ADDRESS" ] || [ -z "$CHANNEL" ]; then
	usage
fi

ENCODED_PASSWORD=$(url_encode "$PASSWORD")

# Determine stream path
case "$STREAM" in
main) STREAM_PATH="Streaming/Channels/${CHANNEL}01" ;;
sub) STREAM_PATH="Streaming/Channels/${CHANNEL}02" ;;
third) STREAM_PATH="Streaming/Channels/${CHANNEL}03" ;;
*)
	echo "Invalid stream type: $STREAM"
	usage
	;;
esac

# Generate the URL
RTSP_URL="rtsp://$USERNAME:$ENCODED_PASSWORD@$IP_ADDRESS:$PORT/$STREAM_PATH"

# Output the URL
echo $RTSP_URL"
