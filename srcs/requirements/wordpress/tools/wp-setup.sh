#!/bin/bash

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h "mariadb" -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent 2>/dev/null; do
	echo "MariaDB not ready, waiting..."
	sleep 2
done

echo "Wordpress DB starting..."
until mariadb \
	-h mariadb \
	-u "${MYSQL_USER}" \
	-p"${MYSQL_PASSWORD}" \
	"${MYSQL_DATABASE}" \
	-e "SELECT 1;" >/dev/null 2>&1
do
	echo "Waiting on Wordpress DB..."
	sleep 2
done

echo "WordPress DB is ready"

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing Wordpress..."
    #curl -o latest.tar.gz https://wordpress.org/latest.tar.gz
    #tar -xzf latest.tar.gz
    #cp -a wordpress/* .
    #rm -rf wordpress latest.tar.gz

    wp core download --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url="http://localhost" \
        --title="My Site" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --allow-root

    wp user create "${WP_USER}" "${WP_EMAIL}" \
        --role=subscriber \
        --user_pass="${WP_PASSWORD}" \
        --allow-root

fi

exec php-fpm8.2 -F
