FROM debian:12

RUN apt-get update && \
    apt-get install -y nginx openssl iputils-ping netcat-openbsd && \ 
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -days 365 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=localhost"

COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

COPY ./requirements/bonus/static-site /var/www/static-site

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
