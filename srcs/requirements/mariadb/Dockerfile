FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Data directory
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Socket directory
#RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/setup.sh .

RUN chmod +x setup.sh

EXPOSE 3306

CMD ["./setup.sh"]
