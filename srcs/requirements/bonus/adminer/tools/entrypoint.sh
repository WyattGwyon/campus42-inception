#!/bin/bash

set -e

mkdir -p /var/run/php
sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /var/www/html
curl -fsSL https://github.com/vrana/adminer/releases/download/v6.3.1/adminer-6.3.1.php -o /var/www/html/adminer.php
chown www-data:www-data /var/www/html/adminer.php
chmod 755 /var/www/html/adminer.php

exec php-fpm8.2 -F
