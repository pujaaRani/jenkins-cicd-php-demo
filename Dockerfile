FROM php
COPY *.php /var/www/html/
RUN docker-php-ext-install mysqli && \
    apt-get update && \
    apt-get install -y zlib1g-dev && \
    docker-php-ext-install zip && \
    a2enmod rewrite
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
EXPOSE 80
CMD ["apache2-foreground"]
