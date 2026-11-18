FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/setup.sh .

RUN chmod +x setup.sh

CMD ["./setup.sh"]
