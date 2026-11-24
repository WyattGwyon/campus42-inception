FROM debian:12

RUN apt-get update && apt-get install -y \
	php8.2-fpm \
	php8.2-mysql \
	curl \
	ca-certificates \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

CMD ["bash", "/usr/local/bin/entrypoint.sh"]
