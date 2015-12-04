# warriormachines/warriormachines-php-fpm

FROM php:5.6-fpm

MAINTAINER "Austin Maddox" <austin@maddoxbox.com>

# Install Laravel framework requirements.
RUN apt-get update \
    && docker-php-ext-install mbstring

# Install GD Library.
RUN apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd

# Install "pdo_mysql" extension.
RUN apt-get install -y \
    php5-mysql \
    && docker-php-ext-install pdo_mysql

# If needed, add a custom php.ini configuration.
COPY ./usr/local/etc/php/php.ini /usr/local/etc/php/php.ini

# Cleanup
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["php-fpm"]
