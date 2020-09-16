FROM nginx:latest

COPY router.conf /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/upstreams

COPY write_upstream.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/write_upstream.sh

EXPOSE 8080
