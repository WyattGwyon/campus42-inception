#!/bin/bash

if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    touch /var/lib/mysql/.initialized
fi

chown -R mysql:mysql /var/lib/mysql

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

echo "Starting MariadDB..."
mysqld --user=mysql \
	--datadir=/var/lib/mysql \
	--bind-address=0.0.0.0 &
	MYSQL_PID=$!

echo "Waiting for mysql to be ready..."

##until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent 2>/dev/null; do
until mysqladmin ping -u root -p"${MYSQL_ROOT_PASSWORD}" --silent 2>/dev/null; do
	echo "Creating Database and user..."
	sleep 5
done

echo "DEBUG: mysqld responding to ping"

if [ ! -f /var/lib/mysql/.sql_initialized ]; then
	echo "Running SQL setup..."
    ##mysql --socket=/run/mysqld/mysqld.sock << EOF
    mysql -u root << EOF
create database if not exists ${MYSQL_DATABASE};
create user if not exists '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';
grant all privileges on ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
alter user 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}';
flush privileges;
EOF
	SQL_EXIT=$?
	echo "DEBUG: SQL block exit code: $SQL_EXIT"
	
#	echo "DEBUG: Shutting down temporary mysqld..."
#	mysqladmin shutdown --socket=/tmp/mysql.sock -u root -p"${MYSQL_ROOT_PASSWORD}"
#	mysqladmin shutdown -u root -p"${MYSQL_ROOT_PASSWORD}"

    if [ "$SQL_EXIT" -eq 0 ]; then
        echo "SQL sucessfully initialized"
        touch /var/lib/mysql/.sql_initialized
    else
        echo "ERROR: SQL Failed initialization with error code ${SQL_EXIT}"
        exit 1
    fi
    #wait $MYSQL_PID
fi

wait $MYSQL_PID
#exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
