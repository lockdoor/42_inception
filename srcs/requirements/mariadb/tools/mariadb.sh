#!/bin/bash

# if volume is empty should install db first
mysql_install_db

# start service mariadb for build unix socket
/etc/init.d/mariadb start

# check if directory wordpress database is exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE_WORDPRESS" ];
then
    echo "Database already exists"
else

# config mariadb
# 1. Enter current password for root (enter for none): [blank]
# 2. Switch to unix_socket authentication [Y/n]: [Y]
# 3. Change the root password? [Y/n]: [Y]
# 4. New password: [use env]
# 5. Re-enter new password: [use env]
# 6. Remove anonymous users? [Y/n]: [Y]
# 7. Disallow root login remotely? [Y/n]: [n]
# 8. Remove test database and access to it? [Y/n]: [Y]
# 9. Reload privilege tables now? [Y/n]: [Y]
mysql_secure_installation << _EOF_ 

Y
Y
mypassword
mypassword
Y
n
Y
Y
_EOF_

#Add a root user on 127.0.0.1 to allow remote connexion 
#Flush privileges allow to your sql tables to be updated automatically when you modify it
#mysql -uroot launch mysql command line client
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user in the database for wordpress
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_WORDPRESS; GRANT ALL ON $MYSQL_DATABASE_WORDPRESS.* TO '$MYSQL_USER_WORDPRESS'@'%' IDENTIFIED BY '$MYSQL_PASSWORD_WORDPRESS'; FLUSH PRIVILEGES;" | mysql -u root

# import wordpress.sql (it have admin and user account)
mysql -u$MYSQL_USER_WORDPRESS -p$MYSQL_PASSWORD_WORDPRESS $MYSQL_DATABASE_WORDPRESS < wordpress.sql

fi

# stop service mariadb before run mariadb for pid1
/etc/init.d/mariadb stop

exec "$@"
