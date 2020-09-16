FROM nginx:latest

COPY router.conf /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/upstreams

COPY write_upstream.sh /usr/local/bin/
COPY write_server.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/write_upstream.sh
RUN chmod +x /usr/local/bin/write_server.sh

EXPOSE 8080
