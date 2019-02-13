FROM php:apache-stretch

COPY docker/start.sh /usr/local/bin/start

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
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini; \
    sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf; \
    sed -ri -e 's!/var/www/!$/var/www/html/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf; \
    chmod u+x /usr/local/bin/start; \
    a2enmod rewrite;

CMD ["/usr/local/bin/start"]