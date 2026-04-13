#!/bin/bash
set -e

CERT_PATH="/etc/ssl/certs/inception.crt"
KEY_PATH="/etc/ssl/private/inception.key"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    echo "🟡 Generando certificado TLS..."
    mkdir -p /etc/ssl/private /etc/ssl/certs

    openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout "$KEY_PATH" \
        -out "$CERT_PATH" \
        -days 365 \
        -subj "/CN=${DOMAIN_NAME}"
fi

echo "🟡 Arrancando NGINX..."
echo "🔨NGINX Workin...🔨"
exec nginx -g "daemon off;"
