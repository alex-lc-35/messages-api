FROM php:8.3-fpm

# Install utils and dev-friendly tools
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    libzip-dev \
    zip \
    libonig-dev \
    vim less nano \
  && docker-php-ext-install pdo pdo_mysql \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Config dev
COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html
