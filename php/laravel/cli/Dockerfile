FROM php

RUN set -eux; \
    apt-get update; \
    # Install common extension
    docker-php-ext-install \
    bcmath \
    iconv \
    opcache \
    pcntl \
    pdo_mysql \
    ; \
    ## Install "zip"
    apt-get install -y --no-install-recommends --no-install-suggests \
    libzip-dev \
    ; \
    docker-php-ext-install zip; \
    ## Install "gd"
    apt-get install -y --no-install-recommends --no-install-suggests \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    ; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
    docker-php-ext-install gd; \
    # Install "mcrypt"
    apt-get install -y --no-install-recommends --no-install-suggests \
    libmcrypt-dev; \
    pecl install mcrypt-1.0.2; \
    docker-php-ext-enable mcrypt; \
    rm -rf /var/lib/apt/lists/*; \
    # PHP Config
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini;

RUN set -eux; \
    curl -s 'https://dl.laravel-china.org/composer.phar' -o /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer; \
    composer config -g repo.packagist composer https://packagist.laravel-china.org
