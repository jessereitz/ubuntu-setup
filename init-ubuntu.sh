#! /usr/bin/env bash

########################
#                      #
#    init-ubuntu.sh    #
#                      #
########################

##########################################################
#                                                        #
# This script initializes all my favorite and most used  #
# programs and settings in Ubuntu. This script should be #
# run on each new installation.                          #
#                                                        #
##########################################################

# Update and upgrade packages
echo "Updating repositories and package lists."
add-apt-repository main
add-apt-repository universe
add-apt-repository multiverse
# Chrome repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt update
echo -e "\n\nUpgrading packages."
apt --assume-yes upgrade
sudo apt-get -y install google-chrome-stable

# Install git
echo -e "\n\nInstalling Git."
apt install --assume-yes git
git config --global user.name "Jesse Reitz"
git config --global user.email "jessereitz1@gmail.com"

# Install Gnome-Tweaks and set up Gnome
echo -e "\n\nInstalling Gnome-Tweaks. Setting up Gnome preferences."
apt install --assume-yes gnome-tweak-tool
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM' $SUDO_USER
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true' $SUDO_USER
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24' $SUDO_USER
su -c 'gsettings set org.gnome.desktop.wm.preferences button-layout "close,maximize,minimize:"' $SUDO_USER
BACKGROUND_IMG_URL="http://i.imgur.com/SJrKG.jpg"
echo "Downloading background image from ${BACKGROUND_IMG_URL}"
BACKGROUND_LOCAL_PATH='/usr/share/backgrounds/default-background.jpg'
wget -O "${BACKGROUND_LOCAL_PATH}" "${BACKGROUND_IMG_URL}"
BACKGROUND_IMG_URI="file://${BACKGROUND_LOCAL_PATH}"
echo "Download complete. Changing background."
su -c "gsettings set org.gnome.desktop.background picture-options 'centered'" $SUDO_USER
su -c "gsettings set org.gnome.desktop.background picture-uri $BACKGROUND_IMG_URI" $SUDO_USER

# Install text editors and their configurations
echo -e "\n\nInstalling Vim, vimrc."
apt install --assume-yes vim
git clone https://github.com/jessereitz/vimrc.git ~/.vim
echo -e "\n\nInstalling Atom."
snap install --classic atom
apm install --assume-yes sync-settings

# Install VirtualBox
apt install --assume-yes virtualbox-qt

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
echo -e "\n\nInstalling Node packages: http-server, eslint, sass"
yes | npm install -g http-server eslint sass

echo -e "\n\nAll packages installed. Don't forget to set up Atom Sync-Settings."

rm ~/init-ubuntu.sh
