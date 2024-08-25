FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache \
    curl mariadb-client php81 php81-fpm php81-phar \
    php81-mysqli php81-curl php81-iconv php81-dom \
    php81-exif php81-gd php81-json php81-fileinfo \
    php81-mbstring php81-openssl php81-xml php81-zip

# Create the 'nginx' user and group
RUN addgroup nginx && \
    adduser -D -S -G nginx nginx

# mount point for our volume
RUN mkdir -p /var/www/html/wordpress

COPY ./conf/www.conf /etc/php81/php-fpm.d/

# downloading wp-cli executable
# then later we will use this command to download the actual wordpress files
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY ./tools/wp_service_start.sh .
RUN chmod 755 wp_service_start.sh

RUN chown -R nginx:nginx /var/www/html/wordpress

# Expose the port
EXPOSE 9000

CMD [ "sh", "wp_service_start.sh"]