FROM php:7.4.1-apache
RUN apt-get update && apt-get install -y \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev libicu-dev libmemcached-dev libbz2-dev libssl-dev librabbitmq-dev libxml2-dev libxslt1.1 libxslt1-dev libzip-dev libpq-dev libssh2-1-dev unzip git \
    && a2enmod rewrite \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gd \
    && git clone https://github.com/esminis/php_pecl_rar.git /usr/src/php/ext/rar \
    && docker-php-ext-configure rar \
    && printf "\n" | pecl install redis \
    && printf "\n" | pecl install mongodb \
    && printf "\n" | pecl install amqp \
    && printf "\n" | pecl install ssh2-1.2 \
    && printf "\n" | pecl install xdebug \
    && docker-php-ext-enable redis mongodb amqp ssh2 xdebug \
    && docker-php-ext-install bcmath bz2 calendar exif opcache pdo_mysql pdo_pgsql intl zip soap gd xsl pcntl sockets rar \
    && chmod 777 /var/log