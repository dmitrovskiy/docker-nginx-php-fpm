#!/bin/sh

exec /usr/bin/php-fpm & \
nginx -g "daemon off;"
