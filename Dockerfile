FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y gnupg curl iproute2 qrencode wireguard python3 && \
    mkdir -p /app

COPY gen.sh /app/gen.sh

WORKDIR /app

RUN chmod +x ./gen.sh && ./gen.sh

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080"]