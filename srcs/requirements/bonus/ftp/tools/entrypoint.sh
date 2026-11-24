#!/bin/bash

FTP_PASSWORD=$(cat /run/secrets/ftp_password)
set -e

if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
	echo "ERROR: FTP_USE and FTP_PASSWORD must be set"
	exit 1
fi

mkdir -p /var/www/html

if ! id "$FTP_USER" >/dev/null 2>&1; then
	useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
fi

echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

usermod -aG www-data "$FTP_USER"
chmod -R g+w /var/www/html

exec /usr/sbin/vsftpd /etc/vsftpd.conf
