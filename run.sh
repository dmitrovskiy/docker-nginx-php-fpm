#!/bin/sh

# php config
# common
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
