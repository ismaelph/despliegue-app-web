FROM php:8.2-cli

RUN apt-get update -y && apt-get install -y libmcrypt-dev libonig-dev && docker-php-ext-install pdo mbstring

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . /app

RUN composer install

# Abre el puerto 8081 para PHP
EXPOSE 8081

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8081"]
