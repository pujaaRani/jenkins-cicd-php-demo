FROM php
COPY *.php /var/www/html/
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
