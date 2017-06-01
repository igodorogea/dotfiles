#!/usr/bin/env bash

function main() {
    if [[ $# -eq 0 || "$1" == "" ]]; then
        show_help
    exit; else
        DOMAIN=$1
        DOMAIN_REGEX='^(([a-zA-Z](-?[a-zA-Z0-9])*)\.)*[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}$'


        if [[ $DOMAIN =~ $DOMAIN_REGEX ]]; then
            echo Succes
        else
            e_error This domain: $DOMAIN is not valid.
        fi
    fi
}

function show_help() {
    read -r -d '' HELP << HELP
        Usage:
        site.sh example.com
HELP

    e_header "$HELP"
}

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

main "$@"

#SITE_LOCATION = /var/www/${DOMAIN}/web/
#CONFIG_NAME = /etc/nginx/sites-available/${DOMAIN}.conf
#
## create site directory
#sudo su -c "mkdir -p ${SITE_LOCATION}" www-data
#
## provide dummy files
#sudo su -c "cp templates/index.html ${SITE_LOCATION}" www-data
#sudo su -c "cp templates/info.php ${SITE_LOCATION}" www-data
#
## create vhost config
#sudo mv templates/vhost.conf ${CONFIG_NAME}
#sudo ln -s ${CONFIG_NAME} /etc/nginx/sites-enabled/
#sudo sed -i 's/server_name www.site.xyz site.xyz;/server_name ${DOMAIN}${DOMAIN_ALIAS};/' ${CONFIG_NAME}
#sudo sed -i 's/root /var/www/site/web;/root ${SITE_LOCATION};/' ${CONFIG_NAME}
#
#sudo service nginx reload
