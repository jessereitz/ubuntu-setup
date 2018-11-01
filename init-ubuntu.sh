#! /usr/bin/env bash

# Update and upgrade packages
add-apt-repository main
add-apt-repository universe
add-apt-repository multiverse
apt update
apt upgrade

# Install git
sudo apt install git
git config --global user.name "Jesse Reitz"
git config --global user.email "jessereitz1@gmail.com"

# Install Gnome-Tweaks
apt install gnome-tweak-tool

# Install text editors and their configurations
apt install vim
git clone https://github.com/jessereitz/vimrc.git ~/
mv ~/vimrc ~/.vim
snap install --classic atom
apm install sync-settings

# Install and set up Python and Python packages
apt install python3-pip
pip3 install virtualenv

# Install Node
apt install nodejs
apt install npm

# Install Node packages
npm install -g http-server eslint sass

echo "All packages installed. Don't forget to set up Atom Sync-Settings."

rm ~/init-ubuntu.sh
