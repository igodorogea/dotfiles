#!/usr/bin/env bash

# add ondrej ppa
sudo apt install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update -y

# install php and required php extensions
sudo apt install -y php7.1-dev php7.1-fpm php7.1-cli php7.1-common php7.1-soap php7.1-xml php7.1-zip php7.1-mbstring php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-json php7.1-mcrypt php7.1-mysql php7.1-readline php7.1-sqlite3 php7.1-tidy php7.1-xmlrpc php7.1-xsl

# install apcu through pecl
sudo echo '' | sudo pecl -q install apcu
echo "extension = apcu.so" | sudo tee -a /etc/php/7.1/mods-available/apcu.ini
sudo ln -s /etc/php/7.1/mods-available/apcu.ini /etc/php/7.1/fpm/conf.d/30-apcu.ini

# install imagemagick
sudo apt install -y imagemagick php-imagick

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/bin --filename=composer
php -r "unlink('composer-setup.php');"

# update php.ini
sudo apt install -y crudini

sudo cp /etc/php/7.1/fpm/php.ini /etc/php/7.1/fpm/php.ini.bak
sudo crudini --merge --format=ini /etc/php/7.1/fpm/php.ini < ${BASH_SOURCE%/*}/templates/php.ini

sudo cp /etc/php/7.1/cli/php.ini /etc/php/7.1/cli/php.ini.bak
sudo crudini --merge --format=ini /etc/php/7.1/cli/php.ini < ${BASH_SOURCE%/*}/templates/php.ini

sudo service php7.1-fpm restart
