FROM debian:12

RUN apt-get update && \
	apt-get install -y redis-server
	apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
RUN ser -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf

CMD ["redis-server", "--protected-mode", "no"]
