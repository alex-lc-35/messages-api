FROM php:8.3-fpm

# Installer les dépendances nécessaires à Composer
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier la config PHP si besoin
COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html
