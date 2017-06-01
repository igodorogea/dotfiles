#!/usr/bin/env bash

sudo apt install -y mariadb-server mariadb-client
sudo mysql_secure_installation
mysql --version
