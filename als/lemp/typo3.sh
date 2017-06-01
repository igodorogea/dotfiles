#!/usr/bin/env bash

# 1. create a simple empty site
source site.sh ${DOMAIN}

# 2. Create mysql db and user
# generate random password
DB_USER_NAME = intro_user
DB_USER_PASS = "$(openssl rand -base64 12)"
DB_NAME = intro_db

sudo mysql -uroot -e <<QUERY
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE 'utf8_unicode_ci';
CREATE USER '${DB_USER_NAME}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';
GRANT ALL ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'localhost';
QUERY

# 3. Install TYPO3 dummy
SITE_ROOT = /var/www/${DOMAIN}

# clear TYPO3 site root folder
sudo rm -rf ${SITE_ROOT}
cd ${SITE_ROOT}

# clone basic distribution and install dependencies
sudo su -c "git clone https://github.com/igodorogea/TYPO3-Distribution ." www-data
sudo su -c "composer install" www-data

# run TYPO3 install setup
sudo su -c "vendor/bin/typo3cms install:setup --non-interactive --database-user-name='${DB_USER_NAME}' --database-user-password='${DB_USER_PASS}' --database-name='${DB_NAME}' --admin-user-name='admin' --admin-password='password' --site-name='${SITE_NAME}'"

sudo chown -R www-data:www-data ${SITE_ROOT}

sudo service nginx reload
