FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y wireguard-tools curl openssl qrencode python3 && \
    mkdir -p /app

COPY gen.sh /app/gen.sh

WORKDIR /app

RUN chmod +x ./gen.sh && ./gen.sh

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080"]