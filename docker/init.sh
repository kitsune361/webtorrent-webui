echo "\n\n++++++++++ Checking IP ++++++++++ "
curl -s ifconfig.co
sleep 5

echo "\n\n++++++++++ Startig up VPN ++++++++++ "
openvpn vpn.conf &
sleep 10

echo "\n\n++++++++++ Re checking IP ++++++++++ "
curl -s ifconfig.co

# build args
if [[ -z "$HYBRID" ]]; then
  HYBRID="false"
fi

if [[ -z "$VERBOSE" ]]; then
  VERBOSE="false"
fi

ARGS="-l 0.0.0.0 -t /tf -d /data"

if [[ ${VERBOSE,,} = "true" ]]; then
echo "\n\n++++++++++ Enabling Verbose Mode ++++++++++ "
  ARGS="$ARGS -v"
fi  

if [[ ${HYBRID,,} = "true" ]]; then
echo "\n\n++++++++++ Enabling Hybrid Mode ++++++++++ "
  ARGS="$ARGS -y"
fi

echo "\n\n++++++++++ Starting torrent engine ++++++++++ "
webtorrent-webui $ARGS
