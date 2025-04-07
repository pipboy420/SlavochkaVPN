#!/bin/bash
set -e

WG_PORT=51820
DOMAIN="slavochkavpn-production.up.railway.app"

SERVER_IP=10.0.0.1
CLIENT_IP=10.0.0.2

# 🔐 Готовые реальные ключи (можешь заменить на свои при желании)
SERVER_PUBLIC_KEY="4I0U3+j8Z2oDuyCNmyYWLeRYKQ9txqsqYgqzG/MR2RQ="
CLIENT_PRIVATE_KEY="JZfIHeG6XIDqOXqY9Uez6Oszf8ZHH3T5NG+UqE2qzHw="

# 📦 Генерация wg0.conf
cat > /app/wg0.conf <<EOF
[Interface]
PrivateKey = ${CLIENT_PRIVATE_KEY}
Address = ${CLIENT_IP}/24
DNS = 1.1.1.1

[Peer]
PublicKey = ${SERVER_PUBLIC_KEY}
Endpoint = ${DOMAIN}:${WG_PORT}
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF

echo "[+] wg0.conf создан ✅"
cat /app/wg0.conf

# QR — для мобилки
qrencode -o /app/wg0.png < /app/wg0.conf || echo "QR не сгенерирован"