# Stage 1: official xray image has no shell — only used to copy the binary out
FROM teddysun/xray:latest AS xray

# Stage 2: Alpine (has /bin/sh) with the xray binary copied in
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/bin/xray /usr/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
