FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y php-fpm

RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]

