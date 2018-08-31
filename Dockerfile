FROM php:7.2-fpm-alpine
MAINTAINER Richard Scoop <richard.scoop@gmail.com>
#Got new configuration from jguyomard/laravel-php

#The following lines allows the first user of the host
#to remain the owner of the files while they are shared with the container
#1000 is the uid and gid of the host user, change if yours is not 1000

RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
    && apk add --no-cache \
        curl \
        git \
        imagemagick \
        mysql-client \
        postgresql-libs \
        libintl \
        icu \
        icu-dev \
    && pecl install imagick xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable imagick xdebug\
    && docker-php-ext-install \
        curl \
        iconv \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        pcntl \
        tokenizer \
        xml \
        zip \
        intl \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && apk del -f .build-deps \
    && docker-php-source delete \
    && rm -rf /var/cache/apk/* \
    && apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data && usermod -g 1000 www-data

USER www-data

WORKDIR /var/www
