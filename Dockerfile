FROM nginx:stable-alpine

MAINTAINER Vladimir Dmitrovskiy vladimir@tep.io

ENV TIMEZONE                UTC
ENV PHP_LISTEN              /var/run/php5-fpm.sock

RUN \
    addgroup -S www-data && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www-data www-data && \

    # Installing php
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \

    apk add --update \
         php5-json \
         php5-pdo \
         php5-zip \
         php5-gd \
         php5-curl \
         php5-dom \
         php5-openssl \
         php5-phar \
         php5-pcntl \
         php5-ctype \
         php5-cli \
         php5-cgi \
         php5-bcmath \
         php5-pcntl \
         php5-opcache \
         php5-fpm && \

    
    # Set environments
    sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php5/php-fpm.conf && \
    sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www-data|g" /etc/php5/php-fpm.conf && \
    sed -i "s|;listen.group\s*=\s*nobody|listen.group = www-data|g" /etc/php5/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = ${PHP_LISTEN}|g" /etc/php5/php-fpm.conf && \
    sed -i "s|include|;include|g" /etc/php5/php-fpm.conf && \

    sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/php.ini && \

    mkdir -p /var/www/html && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*
    
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

COPY ./run.sh /root/run.sh

EXPOSE 80 443

CMD ["/root/run.sh"]
