#!/bin/bash

set -e

# Конфигурация
WG_PORT=51820
WG_INTERFACE=wg0
WG_DIR=/etc/wireguard
WG_PRIVATE_KEY=$(wg genkey)
WG_PUBLIC_KEY=$(echo $WG_PRIVATE_KEY | wg pubkey)
CLIENT_PRIVATE_KEY=$(wg genkey)
CLIENT_PUBLIC_KEY=$(echo $CLIENT_PRIVATE_KEY | wg pubkey)

# IP-сеть
SERVER_IP=10.0.0.1
CLIENT_IP=10.0.0.2

# Создаём директорию
mkdir -p $WG_DIR

# Серверный конфиг
cat > $WG_DIR/$WG_INTERFACE.conf <<EOF
[Interface]
Address = ${SERVER_IP}/24
ListenPort = ${WG_PORT}
PrivateKey = ${WG_PRIVATE_KEY}

[Peer]
PublicKey = ${CLIENT_PUBLIC_KEY}
AllowedIPs = ${CLIENT_IP}/32
EOF

# Клиентский конфиг (wg0.conf)
cat > /app/wg0.conf <<EOF
[Interface]
PrivateKey = ${CLIENT_PRIVATE_KEY}
Address = ${CLIENT_IP}/24
DNS = 1.1.1.1

[Peer]
PublicKey = ${WG_PUBLIC_KEY}
Endpoint = $(curl -s ifconfig.me):${WG_PORT}
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF

# Покажи конфиг и QR
echo -e "\n✅ WireGuard конфиг (wg0.conf):"
cat /app/wg0.conf

echo -e "\n📱 QR-код для мобильного клиента:"
qrencode -t ansiutf8 < /app/wg0.conf