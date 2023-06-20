FROM php
COPY *.php /var/www/html/
EXPOSE 80
CMD ["apache2-foreground"]
