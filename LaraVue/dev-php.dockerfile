FROM php:8.2-fpm-alpine

WORKDIR /var/www/app

EXPOSE 8000

RUN docker-php-ext-install pdo pdo_mysql

ENTRYPOINT [ "php", "/var/www/app/artisan", "serve", "--host", "0.0.0.0" ]
