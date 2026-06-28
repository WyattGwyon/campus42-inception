#!/bin/bash

echo "DEBUG: MYSQL_DATABASE=$MYSQL_DATABASE"
echo "DEBUG: MYSQL_USER=$MYSQL_USER"

#if [ ! -d /var/lib/mysql/mysql ]; then
if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "Initializing MariaDB data directory..."
    rm -rf /var/lib/mysql/*

    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "DEBUG: mysql_install_db done, starting mysqld..."

    touch /var/lib/mysql/.initialized
fi

exec mysqld --user=mysql &
MYSQL_PID=$!


echo "Waiting for mysql to be ready..."
    #mysqld --user=mysql --skip-networking --socket=/tmp/mysql.sock & MYSQL_PID=$!
    #echo "DEBUG: mysqld started with PID $MYSQL_PID"

while ! mysqladmin ping --socket=/tmp/mysql.sock --silent 2>/dev/null; do
	echo "Waiting for MariaDB to start..."
	sleep 5
done
echo "DEBUG: mysqld responding to ping"

echo "DEBUG: Running SQL creation block..."
echo "DEBUG: MYSQL_DATABASE value: ${MYSQL_DATABASE}"
echo "DEBUG: MYSQL_USER value: ${MYSQL_USER}"
echo "DEBUG: MYSQL_DATABASE value: ${MYSQL_PASSWORD}"

if [ ! -f /var/lib/mysql/.sql_initialized ]; then
	echo "Running SQL setup..."
    mysql --socket=/tmp/mysql.sock << EOF
create database if not exists ${MYSQL_DATABASE};
create user if not exists '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';
grant all privileges on ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
alter user 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}';
flush privileges;
EOF
	SQL_EXIT=$?
	echo "DEBUG: SQL block exit code: $SQL_EXIT"
	
	echo "DEBUG: Shutting down temporary mysqld..."
    #mysqladmin shutdown --socket=/tmp/mysql.sock -u root -p"${MYSQL_ROOT_PASSWORD}"

    touch /var/lib/mysql/.sql_initialized
fi

wait $MYSQL_PID
#exec mysqld --user=mysql
