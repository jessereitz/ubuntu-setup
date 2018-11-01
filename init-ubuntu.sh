#! /usr/bin/env bash

# Update and upgrade packages
add-apt-repository main
add-apt-repository universe
add-apt-repository multiverse
# Chrome repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt update
apt --asume-yes upgrade
sudo apt-get -y install google-chrome-stable

# Install git
apt install --assume-yes git
git config --global user.name "Jesse Reitz"
git config --global user.email "jessereitz1@gmail.com"

# Install Gnome-Tweaks
apt install --assume-yes gnome-tweak-tool

# Install text editors and their configurations
apt install --asume-yes vim
git clone https://github.com/jessereitz/vimrc.git ~/.vim
snap install --classic atom
apm install sync-settings

# Install and set up Python and Python packages
apt install --assume-yes python3-pip
pip3 install virtualenv

# Install Node
apt install --assume-yes nodejs
apt install --assume-yes npm
yes | npm install -g npm@latest
yes | npm cache clean --force

# Install Node packages
yes | npm install -g http-server eslint sass

echo "All packages installed. Don't forget to set up Atom Sync-Settings."

rm ~/init-ubuntu.sh
