FROM alpine:latest

RUN apk update && \
    apk add apache2

COPY index.html /var/www/localhost/htdocs/

CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
EXPOSE 80
