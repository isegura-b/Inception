FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	curl\
	netcat-openbsd \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

CMD ["/usr/local/bin/wordpress.sh"]
