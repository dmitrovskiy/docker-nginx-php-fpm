#!/bin/sh

#nginx config
NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:-auto}
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

sed -i "s|worker_processes.*;|worker_processes ${NGINX_WORKER_PROCESSES};|i" /etc/nginx/nginx.conf
sed -i "s|worker_connections.*;|worker_connections ${NGINX_EVENTS_WORKER_CONNECTIONS};|i" /etc/nginx/nginx.conf
sed -i "s|use\s.*;|use ${NGINX_EVENTS_USE};|i" /etc/nginx/nginx.conf
sed -i "s|multi_accept.*;|multi_accept ${NGINX_EVENTS_MULTI_ACCEPT};|i" /etc/nginx/nginx.conf
sed -i "s|sendfile.*;|sendfile ${NGINX_SENDFILE};|i" /etc/nginx/nginx.conf
sed -i "s|tcp_nopush.*;|tcp_nopush ${NGINX_TCP_NOPUSH};|i" /etc/nginx/nginx.conf
sed -i "s|tcp_nodelay.*;|tcp_nodelay ${NGINX_TCP_NODELAY};|i" /etc/nginx/nginx.conf
sed -i "s|server_tokens.*;|server_tokens ${NGINX_SERVER_TOKENS};|i" /etc/nginx/nginx.conf
sed -i "s|types_hash_max_size.*;|types_hash_max_size ${NGINX_TYPES_HASH_MAX_SIZE};|i" /etc/nginx/nginx.conf
sed -i "s|gzip\s.*;|gzip ${NGINX_GZIP};|i" /etc/nginx/nginx.conf
sed -i "s|gzip_static.*;|gzip_static ${NGINX_GZIP_STATIC};|i" /etc/nginx/nginx.conf
sed -i "s|gzip_comp_level.*;|gzip_comp_level ${NGINX_GZIP_COMP_LEVEL};|i" /etc/nginx/nginx.conf
sed -i "s|gzip_min_length.*;|gzip_min_length ${NGINX_GZIP_MIN_LENGTH};|i" /etc/nginx/nginx.conf

sed -i "s|fastcgi_buffer_size.*;|fastcgi_buffer_size ${NGINX_FASTCGI_BUFFER_SIZE};|i" /etc/nginx/conf.d/default.conf
sed -i "s|fastcgi_buffers.*;|fastcgi_buffers ${NGINX_FASTCGI_BUFFERS};|i" /etc/nginx/conf.d/default.conf
sed -i "s|fastcgi_busy_buffers_size.*;|fastcgi_busy_buffers_size ${NGINX_FASTCGI_BUSY_BUFFERS_SIZE};|i" /etc/nginx/conf.d/default.conf
sed -i "s|fastcgi_temp_file_write_size.*;|fastcgi_temp_file_write_size ${NGINX_FASTCGI_TEMP_FILE_WRITE_SIZE};|i" /etc/nginx/conf.d/default.conf

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
