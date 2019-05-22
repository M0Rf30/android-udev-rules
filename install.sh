#!/bin/bash
#
################################
##                            ##
## Install android-udev-rules ##
##                            ##
################################
#
## Install adb and fastboot
sudo apt-get install android-tools-adb android-tools-fastboot

## Clone rules
# git clone https://github.com/M0Rf30/android-udev-rules.git
# this line has been included to give credit to the work I built on
git clone https://github.com/lehmancurtis147/android-udev-rules.git

## Install rules
if [ ! /usr/lib/sysusers.d/android-udev.conf ]; then
    sudo cp ./android-udev.conf /usr/lib/sysusers.d
else
    echo "android-udev.conf already exist"
fi

if [ ! /etc/udev/rules.d/51-andriod.rules ]; then
    sudo cp -v ./51-android.rules /etc/udev/rules.d;
    sudo chmod a+r /etc/udev/rules.d/51-android.rules
else
    echo "rules are already installed"
fi

## Set up adb users group
#
# Delete old rules
sudo groupdel adbusers

# Configure adbusers
if [ ! /usr/lib/sysusers.d/ ]; then
    sudo mkdir -p /usr/lib/sysusers.d/ && sudo cp android-udev.conf /usr/lib/sysusers.d/
else
    echo "adbusers already configured"
fi

sudo systemd-sysusers # (1)

# Add user to adb group
sudo usermod -a -G adbusers $(whoami)

# Reload rules
sudo udevadm control --reload-rules

# Start udev services
sudo service udev restart

# Reset adb server
sudo adb kill-server
sudo adb devices
