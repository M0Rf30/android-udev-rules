#!/bin/bash
#
clear
## Colors
BLUE='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
WHITE='\e[37m'
NC='\e[0m'
#
function confirm(){
    read -p "$*"
}
#
echo ""
echo -e "    ${PURPLE} _________      ___              __           _     __ "
echo -e "    / ____<  /     /   |  ____  ____/ /________  (_)___/ / ${NC}"
echo -e "  ${BLUE} /___ \ / /_____/ /| | / __ \/ __  / ___/ __ \/ / __  / "
echo -e "  ____/ // /_____/ ___ |/ / / / /_/ / /  / /_/ / / /_/ / ${NC}"
echo -e "${CYAN} /_____//_/     /_/  |_/_/ /_/\__,_/_/   \____/_/\__,_/ ${CYAN}"
echo "                                                BY: lehmancurtis147"
wait
echo ""
echo ""
confirm 'press [enter] if you wish to proceed, or ctrl+c to exit'
#
## Install adb and fastboot
sudo apt-get install android-tools-adb android-tools-fastboot

## Clone rules
# git clone https://github.com/M0Rf30/android-udev-rules.git
## this line has been included to give credit to the work I built on

## Install rules
if [ ! /usr/lib/sysusers.d/android-udev.conf ]; then
    sudo cp ./android-udev.conf /usr/lib/sysusers.d
fi

if [ ! /etc/udev/rules.d/51-andriod.rules ]; then
    sudo cp -v ./51-android.rules /etc/udev/rules.d;
    sudo chmod a+r /etc/udev/rules.d/51-android.rules
fi

## Set up adb users group
#
# Delete old rules
sudo groupdel adbusers; sudo addgroup adbusers

# Configure adbusers
if [ ! /usr/lib/sysusers.d/ ]; then
    sudo mkdir -p /usr/lib/sysusers.d/ && sudo cp android-udev.conf /usr/lib/sysusers.d/
fi

sudo systemd-sysusers # (1)

# Add user to adbusers
sudo usermod -a -G adbusers $(whoami)

# Reload rules
sudo udevadm control --reload-rules

# Start udev services
sudo service udev restart

# Reset adb server
sudo adb kill-server

sudo adb devices
