FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y php-fpm php-mysql curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp 

RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wp-setup.sh .

RUN chmod +x wp-setup.sh

CMD ["./wp-setup.sh"]

