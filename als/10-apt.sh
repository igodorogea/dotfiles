#!/usr/bin/env bash

sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -yq
sudo apt install -y mc
sudo apt autoclean
sudo apt autoremove -y

# Install Oh my zsh for ubuntu user
sudo apt install -y zsh git-core
sudo chsh -s $(which zsh) $USER
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"/' .zshrc

# Install Oh my zsh for www-data user
sudo mkdir -p /var/www
sudo chown -R www-data:www-data /var/www
sudo chsh -s $(which zsh) www-data
sudo su -c "wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true" www-data
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"/' /var/www/.zshrc
