#! /usr/bin/env bash

# Update and upgrade packages
echo "Updating repositories and package lists."
add-apt-repository main
add-apt-repository universe
add-apt-repository multiverse
# Chrome repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt update
echo "\n\nUpgrading packages."
apt --assume-yes upgrade
sudo apt-get -y install google-chrome-stable

# Install git
echo "\n\nInstalling Git."
apt install --assume-yes git
git config --global user.name "Jesse Reitz"
git config --global user.email "jessereitz1@gmail.com"

# Install Gnome-Tweaks and set up Gnome
echo "\n\nInstalling Gnome-Tweaks. Setting up Gnome preferences."
apt install --assume-yes gnome-tweak-tool
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true


# Install text editors and their configurations
echo "\n\nInstalling Vim, vimrc."
apt install --assume-yes vim
git clone https://github.com/jessereitz/vimrc.git ~/.vim
echo "\n\nInstalling Atom."
snap install --classic atom
apm install --assume-yes sync-settings

# Install and set up Python and Python packages
echo "\n\nInstalling python3-pip, virtualenv."
apt install --assume-yes python3-pip
pip3 install virtualenv

# Install Node
echo "\n\nInstalling Node, NPM."
apt install --assume-yes nodejs npm
yes | npm install -g npm@latest
# Clear the npm cache to use updated npm version
yes | npm cache clean --force

# Install Node packages
echo "\n\nInstalling Node packages: http-server, eslint, sass"
yes | npm install -g http-server eslint sass

echo "\n\nAll packages installed. Don't forget to set up Atom Sync-Settings."

rm ~/init-ubuntu.sh
