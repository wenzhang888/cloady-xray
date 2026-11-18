#!/bin/sh
# Generates /etc/xray/config.json from env vars at container start, then runs xray.
# UUID and WS_PATH must be set as environment variables on the platform (never commit them).
set -e
: "${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/ray}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "inbounds": [
    {
      "port": 3000,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": ""
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$WS_PATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
exec /usr/bin/xray run -c /etc/xray/config.json
