FROM debian:bookworm-slim

RUN apt update
RUN apt install -y nginx
RUN rm -rf /var/log/nginx/access.log && ln -s /dev/stdout /var/log/nginx/access.log
RUN rm -rf /var/log/nginx/error.log && ln -s /dev/stderr /var/log/nginx/error.log

# COPY tasks/html-files/nginx-html-index/*.html tasks/html-files/nginx-html-index/css/ tasks/html-files/nginx-html-index/assets/ /var/www/html/
# COPY tasks/html-files/nginx-html-index/ /var/www/html/
ADD ./html.tar.gz /var/www/html/

# EXPOSE 80

# VOLUME [ "/test-data" ]

# CMD nginx -g 'daemon off;'
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]