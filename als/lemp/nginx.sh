#!/usr/bin/env bash

# install nginx
sudo apt install -y nginx
#sudo service nginx status
nginx -v

sudo chown -R www-data:www-data /var/www

# update nginx.conf
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo cp ${BASH_SOURCE%/*}/templates/nginx.conf /etc/nginx/nginx.conf

sudo service nginx reload
