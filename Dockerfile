# warriormachines/warriormachines-php-fpm

FROM php:5.6-fpm

MAINTAINER "Austin Maddox" <austin@maddoxbox.com>

RUN apt-get update

RUN docker-php-ext-install mbstring mysql mysqli pdo_mysql

# Install PHP zipfile extension. (Adds ZipArchive class)
RUN apt-get install -y \
    zlib1g-dev \
    && docker-php-ext-install zip

# Install GD library.
RUN apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd

# Install `ImageMagick` (Linux app) and `imagick` PHP extension.
RUN apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# If needed, add a custom php.ini configuration.
COPY ./usr/local/etc/php/php.ini /usr/local/etc/php/php.ini

# Cleanup
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["php-fpm"]
