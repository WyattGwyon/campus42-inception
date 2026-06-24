FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y php-fpm php-mysql curl

RUN mkdir -p /run/php
#RUN mkdir -p /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wp-setup.sh .

RUN chmod +x wp-setup.sh

CMD ["./wp-setup.sh"]

