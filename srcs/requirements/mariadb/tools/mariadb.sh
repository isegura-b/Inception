#!/bin/bash
set -e

MYSQL_PASSWORD="$(cat /run/secrets/db_password)"
MYSQL_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"

chown -R mysql:mysql /var/lib/mysql

echo "🟢 Comprobando si MariaDB ya está inicializada..."

if [ ! -f "/var/lib/mysql/.mariadb_setup_done" ]; then
	echo "🟢 Inicializando MariaDB..."

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
	mysqld_safe --datadir=/var/lib/mysql &

	until mariadb-admin ping --silent; do #waiting DB
		sleep 1
	done

	#password to DB
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	#crates DB
	mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
	#creates user that connects to WP
	mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	#user permissions on DB
	mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
	#recharge permissions
	mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
	#shutdown config DB
	mariadb-admin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

	touch /var/lib/mysql/.mariadb_setup_done
	echo "🟢 Flag"
fi

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "🟢 Arrancando MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0

