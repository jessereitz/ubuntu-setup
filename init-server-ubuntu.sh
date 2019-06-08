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

echo -e "\n\n"
echo "###########################"
echo "#                         #"
echo "#   Ubuntu Server Setup   #"
echo "#                         #"
echo "###########################"
echo

if [ "$EUID" -ne 0 ]; then
    echo "We're doing some pretty heavy stuff here."
    echo "Please run this shit as root."
    exit
fi

echo "Setting up an Ubuntu server installation just how Jesse likes."
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


if [ "$1" == "--auto-ssh-keys" ]; then
    echo "'auto-ssh-keys' option provided. SSH keys will be pulled from github/jessereitz every two hours."
    cur_date=`date --iso-8601=ns`
    mkdir -p /home/jessereitz/scripts/.bak
    echo "Copying current crontab to '/home/jessereitz/scripts/.bak' if you need it in the future."
    crontab -l -u jessereitz > /home/jessereitz/scripts/.bak/crontab_${cur_date}.bak
    echo "Copying download script."
    cp ./scripts/update-ssh-keys.sh /home/jessereitz/scripts
    echo "Creating cron entry"
    (crontab -l 2>/dev/null; echo "0 2 * * * /home/jessereitz/scripts/update-ssh-keys.sh") | crontab -u jessereitz -
    chown -R jessereitz:jessereitz /home/jessereitz/scripts
    echo "Done."
fi

# # Update and upgrade packages
# echo "Updating repositories and package lists."
# add-apt-repository main
# add-apt-repository universe
# add-apt-repository multiverse
# apt --assume-yes update
# echo -e "\n\nUpgrading packages."
# apt --assume-yes upgrade

# # Install git
# echo -e "\n\nInstalling and configuring Git. It should already be on here but, y'know."
# apt install --assume-yes git
# git config --global user.name "Jesse Reitz"
# git config --global user.email "jessereitz1@gmail.com"

# echo -e "\n\nInstalling Unattended Upgrades."
# apt install --assume-yes unattended-upgrades

# # Install Glances
# echo -e "\n\nInstalling Glances"
# apt install --assume-yes glances

# # Install net-tools, curl,  and speedtest
# echo -e "\n\nInstalling Net Tools"
# apt install --assume-yes net-tools
# echo -e "\n\nInstalling Curl"
# apt install --assume-yes curl
# echo -e "\n\nInstalling Speed Test"
# apt install --assume-yes speedtest-cli

# # Install text editors and their configurations
# echo -e "\n\nInstalling Vim, vimrc."
# apt install --assume-yes vim-gtk
# git clone https://github.com/jessereitz/vimrc.git /home/jessereitz/.vim
# chown -R jessereitz:jessereitz /home/jessereitz/vim
# vim +PlugInstall +qall

# # Install and set up Python and Python packages
# echo -e "\n\nInstalling python3-pip, virtualenv."
# apt install --assume-yes python3-pip
# pip3 install virtualenv

# # Install Node
# echo -e "\n\nInstalling Node, NPM."
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
# sudo apt-get install -y nodejs
# yes | npm install -g npm@latest
# # Clear the npm cache to use updated npm version
# yes | npm cache clean --force

# # Install Node packages
# echo -e "\n\nInstalling Node packages: http-server, eslint, sass, nodemon"
# yes | npm install -g http-server eslint sass nodemon

# echo -e "\n\nAll packages installed."

