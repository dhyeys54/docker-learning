FROM debian:bookworm-slim

RUN apt update
RUN apt install -y nginx
RUN rm -rf /var/log/nginx/access.log && ln -s /dev/stdout /var/log/nginx/access.log
RUN rm -rf /var/log/nginx/error.log && ln -s /dev/stderr /var/log/nginx/error.log

# CMD nginx -g 'daemon off;'
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]