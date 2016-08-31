#!/bin/sh

#nginx config
NGINX_WORKER_PROCESES=${NGINX_WORKER_PROCESES:-auto}
NGINX_EVENTS_WORKER_CONNECTIONS=${NGINX_WORKER_CONNECTIONS:-1024}
NGINX_EVENTS_USE=${NGINX_EVENTS_USE:-epoll}
NGINX_EVENTS_MULTI_ACCEPT=${NGINX_EVENTS_MULTI_ACCEPT:-on}
NGINX_SENDFILE=${NGINX_SENDFILE:-on}
NGINX_TCP_NOPUSH=${NGINX_TCP_NOPUSH:-on}
NGINX_TCP_NODELAY=${NGINX_TCP_NODELAY:-on}
NGINX_SERVER_TOKENS=${NGINX_SERVER_TOKENS:-off}
NGINX_TYPES_HASH_MAX_SIZE=${NGINX_TYPES_HASH_MAX_SIZE:-2048}

# gzip
NGINX_GZIP=${NGINX_GZIP:-on}
NGINX_GZIP_STATIC=${NGINX_GZIP_STATIC:-on}
NGINX_GZIP_COMP_LEVEL=${NGINX_GZIP_COMP_LEVEL:-5}
NGINX_GZIP_MIN_LENGTH=${NGINX_GZIP_MIN_LENGTH:-1024}
NGINX_GZIP_HTTP_VERSION=${NGINX_GZIP_HTTP_VERSION:-1.1}
NGINX_GZIP_PROXIED=${NGINX_GZIP_PROXIED:-any}
NGINX_GZIP_VARY=${NGINX_GZIP_VARY:-on}
NGINX_GZIP_TYPES=${NGINX_GZIP_TYPES:-text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript text/x-js}
NGINX_GZIP_DISABLE=${NGINX_GZIP_DISABLE:-"msie6"}

# fastcgi
NGINX_FASTCGI_BUFFER_SIZE=${NGINX_FASTCGI_BUFFER_SIZE:-128k}
NGINX_FASTCGI_BUFFERS=${NGINX_FASTCGI_BUFFERS:-256 16k}
NGINX_FASTCGI_BUSY_BUFFERS_SIZE=${NGINX_FASTCGI_BUSY_BUFFERS_SIZE:-256k}
NGINX_FASTCGI_TEMP_FILE_WRITE_SIZE=${NGINX_FASTCGI_TEMP_FILE_WRITE_SIZE:-256k}

# php config
PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-512M}
PHP_MAX_UPLOAD=${PHP_MAX_UPLOAD:-50M}
PHP_MAX_FILE_UPLOAD=${PHP_MAX_FILE_UPLOAD:-200}
PHP_MAX_POST=${PHP_MAX_POST:-100M}

# opcache
PHP_OPCACHE_ENABLE=${PHP_OPCACHE_ENABLE:-0}
PHP_OPCACHE_ENABLE_CLI=${PHP_OPCACHE_ENABLE_CLI:-0}
PHP_OPCACHE_MEMORY_CONSUMPTION=${PHP_OPCACHE_MEMORY_CONSUMPTION:-128}
PHP_OPCACHE_MAX_ACCELERATED_FILES=${PHP_OPCACHE_MAX_ACCELERATED_FILES:-10000}
PHP_OPCACHE_MAX_WASTED_PERCENTAGE=${PHP_OPCACHE_MAX_WASTED_PERCENTAGE:-10}
PHP_OPCACHE_VALIDATE_TIMESTAMPS=${PHP_OPCACHE_VALIDATE_TIMESTAMPS:-0}

sed -i "s|;*memory_limit\s*=\s*.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini
sed -i "s|;*upload_max_filesize\s*=\s*.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*max_file_uploads\s*=\s*.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*post_max_size\s*=\s*.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini

sed -i "s|;*opcache\.enable\s*=\s*.*|opcache\.enable = ${PHP_OPCACHE_ENABLE}|i" /etc/php5/php.ini
sed -i "s|;*opcache\.enable_cli\s*=\s*.*|opcache\.enable_cli = ${PHP_OPCACHE_ENABLE_CLI}|i" /etc/php5/php.ini
sed -i "s|;*opcache\.memory_consumption\s*=\s*.*|opcache\.memory_consumption = ${PHP_OPCACHE_MEMORY_CONSUMPTION}|i" /etc/php5/php.ini
sed -i "s|;*opcache\.max_accelerated_files\s*=\s*.*|opcache\.max_accelerated_files = ${PHP_OPCACHE_MAX_ACCELERATED_FILES}|i" /etc/php5/php.ini
sed -i "s|;*opcache\.max_wasted_percentage\s*=\s*.*|opcache\.max_wasted_percentage = ${PHP_OPCACHE_MAX_WASTED_PERCENTAGE}|i" /etc/php5/php.ini
sed -i "s|;*opcache\.validate_timestamps\s*=\s*.*|opcache\.validate_timestamps = ${PHP_OPCACHE_VALIDATE_TIMESTAMPS}|i" /etc/php5/php.ini

exec /usr/bin/php-fpm & nginx -g "daemon off;"
