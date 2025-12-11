FROM php:7.4-apache

# Install required packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libzip-dev \
    libjpeg-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    iputils-ping \
    default-mysql-client \
    && docker-php-ext-install pdo_mysql mysqli zip gd mbstring exif pcntl bcmath opcache

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy the PHP Source Code folder into Apache
WORKDIR /var/www/html
COPY . ./

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]

