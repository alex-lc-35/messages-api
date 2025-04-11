FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    libzip-dev \
    zip \
    libonig-dev

# Installe les extensions PDO nécessaires
RUN docker-php-ext-install pdo pdo_mysql

# Installe Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html
