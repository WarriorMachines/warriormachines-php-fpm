# warriormachines/warriormachines-php-fpm

FROM php:5.6.18-fpm

MAINTAINER "Austin Maddox" <austin@maddoxbox.com>

RUN apt-get update

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql

# Install GD library.
RUN apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd

# Install Imagick.
RUN apt-get install -y \
    libmagickwand-dev
RUN pecl install imagick
RUN docker-php-ext-enable imagick

# If needed, add a custom php.ini configuration.
COPY ./usr/local/etc/php/php.ini /usr/local/etc/php/php.ini

# Cleanup
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["php-fpm"]
