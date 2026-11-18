# xray on Cloady (VLESS + WS + TLS)

Multi-stage Dockerfile: the official `teddysun/xray` image has no shell, so the
xray binary is copied into Alpine, which does.

## How it runs

- Container listens on port **3000** (plain WebSocket inside the container).
- The platform exposes it on public port **443** with TLS terminated at the
  edge, so clients still connect with VLESS + WS + TLS.
- The xray config is generated at container start from environment variables,
  so no credential is ever committed to this repo.

## Required environment variables (set on the Cloady dashboard)

- `UUID` — the VLESS client id.
- `WS_PATH` — the WebSocket path, e.g. `/your-random-path`.

## Client link (after deploy, replace `<domain>` with the assigned domain)

`vless://<UUID>@<domain>:443?encryption=none&security=tls&sni=<domain>&type=ws&path=<WS_PATH>#cloady-usw1`
