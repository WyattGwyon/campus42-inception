#!/bin/bash


cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing Wordpress..."
    curl -o latest.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -a wordpress/* .
    rm -rf wordpress latest.tar.gz
fi

exec php-fpm7.4 -F
