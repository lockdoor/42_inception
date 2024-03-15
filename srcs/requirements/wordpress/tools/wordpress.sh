#!/bin/bash

#check if wp-config.php exist
if [-f ./wp-config.php]
then
    echo "wordpress already downloaded"
else

	#Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#Inport env variables in the config file
	sed -i "s/username_here/$MYSQL_USER_WORDPRESS/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD_WORDPRESS/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE_WORDPRESS/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	#redis bonus part
	# https://github.com/rhubarbgroup/redis-cache/blob/develop/INSTALL.md
	# can test redis work with command redis-cli -> scan [number]
	wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	#wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
fi

exec "$@"
