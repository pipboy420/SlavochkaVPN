FROM debian:bullseye-slim

RUN apt update && \
    apt install -y wireguard iproute2 curl qrencode python3 && \
    mkdir -p /app

COPY gen.sh /app/gen.sh

WORKDIR /app

RUN chmod +x ./gen.sh && ./gen.sh

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080"]