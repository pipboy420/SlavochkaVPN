FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y shadowsocks-libev simple-obfs curl && \
    mkdir -p /etc/shadowsocks

COPY ss.json /etc/shadowsocks/config.json

EXPOSE 8388

CMD ss-server -c /etc/shadowsocks/config.json --fast-open --plugin obfs-server --plugin-opts "obfs=http"