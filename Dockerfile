FROM php:8.1-apache

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libicu-dev    # Agregamos el paquete de desarrollo de ICU para la extensión intl

RUN docker-php-ext-install intl   # Instalamos la extensión intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar CodeIgniter desde cero
WORKDIR /var/www/html/

USER www-data

RUN composer create-project codeigniter4/appstarter . --no-cache

USER root

EXPOSE 80

# Referencias

# https://github.com/docker-library/docs/blob/master/php/README.md#supported-tags-and-respective-dockerfile-links

# https://stackoverflow.com/questions/51443557/how-to-install-php-composer-inside-a-docker-container