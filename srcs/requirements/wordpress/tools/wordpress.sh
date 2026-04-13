#!/bin/bash

set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
WP_PATH="/var/www/html"
DB_HOST="mariadb"

echo "🔵 Iniciando WordPress..."

mkdir -p /run/php

echo "⌚ Esperando a MariaDB..."
until nc -z "$DB_HOST" 3306; do
	sleep 2
done

if [ ! -f /usr/local/bin/wp ]; then
	echo "🔵 Instalando WP-CLI..."
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f "$WP_PATH/wp-config.php" ]; then
	echo "🔵 Configurando WordPress..."

	cd "$WP_PATH"

	if [ ! -f "$WP_PATH/wp-load.php" ]; then
		wp core download --allow-root --path="$WP_PATH"
	fi

	wp config create \
		--allow-root \
		--path="$WP_PATH" \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="${DB_HOST}"

	wp core install \
		--allow-root \
		--path="$WP_PATH" \
		--url="https://${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}"

	wp user create \
		--allow-root \
		--path="$WP_PATH" \
		"${WP_USER}" "${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}"
fi

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

echo "🔵 Arrancando PHP-FPM..."
exec php-fpm7.4 -F
