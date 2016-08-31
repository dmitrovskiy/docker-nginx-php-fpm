#!/bin/sh

PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-512M}
PHP_MAX_UPLOAD=${PHP_MAX_UPLOAD:-50M}
PHP_MAX_FILE_UPLOAD=${PHP_MAX_FILE_UPLOAD:-200}
PHP_MAX_POST=${PHP_MAX_POST:-100M}

sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini

exec /usr/bin/php-fpm & \
nginx -g "daemon off;"
