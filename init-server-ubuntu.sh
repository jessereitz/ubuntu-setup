#! /usr/bin/env bash

###############################
#                             #
#    init-server-ubuntu.sh    #
#                             #
###############################

##########################################################
#                                                        #
# This script initializes the core packages I use most   #
# frequently in Ubuntu. This script should be run on     #
# each new installation of Ubuntu server and Ubuntu      #
# desktop.                                               #
#                                                        #
##########################################################

# Update and upgrade packages
echo "Updating repositories and package lists."
add-apt-repository main
add-apt-repository universe
add-apt-repository multiverse
apt --assume-yes update
echo -e "\n\nUpgrading packages."
apt --assume-yes upgrade

# Install Glances
echo -e "\n\nInstalling Glances"
apt install --assume-yes glances

# Install net-tools and speedtest
echo -e "\n\nInstalling Net Tools"
apt install --assume-yes net-tools
echo -e "\n\nInstalling Speed Test"
apt install --assume-yes speedtest-cli

# Install text editors and their configurations
echo -e "\n\nInstalling Vim, vimrc."
apt install --assume-yes vim-gtk
git clone https://github.com/jessereitz/vimrc.git ~/.vim
vim +PlugInstall +qall

# Install and set up Python and Python packages
echo -e "\n\nInstalling python3-pip, virtualenv."
apt install --assume-yes python3-pip
pip3 install virtualenv

# Install Node
echo -e "\n\nInstalling Node, NPM."
apt install --assume-yes nodejs npm
yes | npm install -g npm@latest
# Clear the npm cache to use updated npm version
yes | npm cache clean --force

# Install Node packages
echo -e "\n\nInstalling Node packages: http-server, eslint, sass, nodemon"
yes | npm install -g http-server eslint sass nodemon

echo -e "\n\nAll packages installed."

