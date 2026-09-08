FROM mynginx:latest

RUN apt-get update && apt-get gettext-base

ENV PROXY_PROTOCOL=http PROXY_UPSTREAM=example.com

COPY tasks/nginx-loadbalancer/proxy.conf /etc/nginx/sites-available/default.template
COPY tasks/tasks/nginx-loadbalancer/start.sh /

CMD ["/start.sh"]