#!/bin/bash

ln -s /usr/bin/php81 /usr/bin/php

WP_CONFIG_FILE=wp-config.php

if [ ! -f $WP_CONFIG_FILE ]; then
	# downloading wp core files
    wp core download --allow-root

    wp config create --allow-root \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_USER_PASSWORD \
        --dbhost=$MARIADB_HOST \
        --dbcharset="utf8"

    echo $?
	if [ $? -ne 0 ]; then
        echo "Failure to create wp-conf file!!!!!!!!!!!!"
        return 1
    fi

	# we have to specify the administrator
	wp core install --allow-root --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASS \
        --admin_email=$WP_ADMIN_EMAIL
	
	if [ $? -ne 0 ]; then
        echo "Failure to install admin and shit!!!!!!!!!!!!"
        return 1
    fi
	wp user create --allow-root $WP_USER $WP_EMAIL --role=author --user_pass=$WP_USER_PASS
    wp user create --allow-root "student" "student@42.fr" --role=author --user_pass="s123"

fi

php-fpm81 -F # php server running
