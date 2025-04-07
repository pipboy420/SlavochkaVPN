#!/bin/bash
set -e

WG_PORT=51820
WG_INTERFACE=wg0
SERVER_IP=10.0.0.1
CLIENT_IP=10.0.0.2

# Генерируем ключи
SERVER_PRIV=$(wg genkey)
SERVER_PUB=$(echo $SERVER_PRIV | wg pubkey)
CLIENT_PRIV=$(wg genkey)
CLIENT_PUB=$(echo $CLIENT_PRIV | wg pubkey)

# Генерация wg0.conf
cat > /app/wg0.conf <<EOF
[Interface]
PrivateKey = $CLIENT_PRIV
Address = $CLIENT_IP/24
DNS = 1.1.1.1

[Peer]
PublicKey = $SERVER_PUB
Endpoint = slavochkavpn-production.up.railway.app:$WG_PORT
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF