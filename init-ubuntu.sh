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
ALL_ARGS=${@: -1}

echo -e "\n\n"
echo "####################"
echo "#                  #"
echo "#   Ubuntu Setup   #"
echo "#                  #"
echo "####################"
echo

if [ "$EUID" -ne 0 ]; then
    echo "We're doing some pretty heavy stuff here."
    echo "Please run this shit as root."
    exit
fi

echo "Setting up an Ubuntu desktop installation just how Jesse likes."
echo
echo "This script will install and configure my most commonly programs."
echo "Keep in mind:"
echo -e "\t* This is designed to work for Ubuntu and Ubuntu derivatives ONLY. Even then, things tend to break with new OS releases"
echo -e "\t* This MUST be run as root from the 'ubuntu-setup' directory"
echo -e "\t* This script expects the user to be 'jessereitz' and for the home directory to be '/home/jessereitz'. If you don't like that, too bad"

echo
last_arg=${@: -1}
if [ "$last_arg" == "-y" ]; then
    echo "You passed the '-y' flag. Assuming you would like to proceed."
else
    read -p "Would you like to proceed? [y|n]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo
        echo "You have chosen not to continue. Evaluate your life decisions and come back when you're ready."
        exit 1
    fi
fi
echo
echo 'You have chosen to continue. Get ready for awesome.'
echo -e "\n\n"

# Add Chrome repository
echo "Adding Chrome repository for installation later."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

./init-server-ubuntu.sh $ALL_ARGS -y

sudo apt-get -y install google-chrome-stable

# Install ssh-server
echo -e "\n\nInstalling SSH server"
apt install --assume-yes openssh-server

# Install Gnome-Tweaks and set up Gnome
echo -e "\n\nInstalling Gnome-Tweaks. Setting up Gnome preferences."
apt install --assume-yes gnome-tweak-tool
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM' $SUDO_USER
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true' $SUDO_USER
su -c 'gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24' $SUDO_USER
su -c 'gsettings set org.gnome.desktop.wm.preferences button-layout "close,maximize,minimize:"' $SUDO_USER

echo -e "\n\nAll packages installed."

