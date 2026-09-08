FROM mynginx:latest

RUN apt-get update && apt-get install -y gettext-base

ENV PROXY_PROTOCOL=http PROXY_UPSTREAM=web01:4567

COPY proxy.conf /etc/nginx/sites-available/default.template
COPY start.sh /

CMD ["/start.sh"]