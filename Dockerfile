FROM php:8.1.1-fpm-alpine3.15

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS curl-dev libtool libxml2-dev

# Install production dependencies
RUN apk add --no-cache bash curl freetype-dev gcc git \
    icu-dev icu-libs libc-dev libjpeg-turbo-dev libpng-dev \
    libzip-dev make mysql-client nodejs \oniguruma-dev \
    yarn openssh-client postgresql-libs rsync zlib-dev

# Configure php extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install php extensions
RUN docker-php-ext-install bcmath calendar curl exif gd \
    iconv intl mbstring pdo_mysql pcntl xml zip opcache

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www
