FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/nginx.sh /usr/local/bin/nginx.sh

RUN chmod +x /usr/local/bin/nginx.sh

CMD ["/usr/local/bin/nginx.sh"]
