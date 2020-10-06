FROM php:7.4-fpm-alpine

# Install production dependencies
RUN apk add --no-cache \
    freetype-dev \
    g++ \
    gcc \
    git \
    icu-dev \
    icu-libs \
    libc-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    make \
    mysql-client \
    nodejs \
    nodejs-npm \
    oniguruma-dev \
    yarn \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev

# xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# phan
RUN pecl install ast-1.0.3 && \
    docker-php-ext-enable ast
ENV PHAN_ALLOW_XDEBUG 1

# Install php extensions
RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    intl \
    mbstring \
    pdo \
    pdo_mysql \
    pcntl \
    tokenizer \
    xml \
    zip

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"
# composer(prestissimo)
RUN composer global require hirak/prestissimo

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www
