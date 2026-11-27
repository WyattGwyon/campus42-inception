FROM debian:12

RUN apt-get update && apt-get install -y \
	curl \
	ca-certificates \
	git \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -fsSLO https://nodejs.org/dist/v24.22.3/node-v24.22.3-linux-x64.tar.gz \
    && tar -xzf node-v24.22.3-linux-x64.tar.gz -C /usr/local --strip-components=1 \
    && rm node-v24.22.3-linux-x64.tar.gz

WORKDIR /app

RUN git clone https://github.com/louislam/uptime-kuma.git .

RUN npm run setup

EXPOSE 3001

ENV UPTIME_KUMA_DB_TYPE=sqlite

CMD ["node", "server/server.js"]
