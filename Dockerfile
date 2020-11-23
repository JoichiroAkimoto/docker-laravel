FROM php:7.4-fpm-alpine

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS curl-dev libtool libxml2-dev

# Install production dependencies
RUN apk add --no-cache bash curl freetype-dev gcc git \
    icu-dev icu-libs libc-dev libjpeg-turbo-dev libpng-dev \
    libzip-dev make mysql-client nodejs nodejs-npm \oniguruma-dev \
    yarn openssh-client postgresql-libs rsync zlib-dev

# xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# phan
RUN pecl install ast-1.0.3 && \
    docker-php-ext-enable ast
ENV PHAN_ALLOW_XDEBUG 1

# Configure php extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install php extensions
RUN docker-php-ext-install bcmath calendar curl exif gd \
    iconv intl mbstring pdo_mysql pcntl tokenizer xml zip opcache

# Install composer
# ENV COMPOSER_HOME /composer
# ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
# ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www
