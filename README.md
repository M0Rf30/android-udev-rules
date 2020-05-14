# android-udev-rules

## Description

These rules refer to [Run Apps on a Hardware Device - Android Studio](https://developer.android.com/studio/run/device.html) and include many suggestions from the Archlinux and Github Communities.


## Installation

### Arch

On Arch it should be enough to follow the [instructions for connecting a device on the Arch wiki](https://wiki.archlinux.org/index.php/Android_Debug_Bridge). There's no need to clone this repository.


### Ubuntu

```sh
# Clone this repository
git clone https://github.com/M0Rf30/android-udev-rules.git
cd android-udev-rules
    
# Copy rules file
sudo cp -v 51-android.rules /etc/udev/rules.d/51-android.rules
    
# OR create a sym-link to the rules file - choose this option if you'd like to update your udev rules using git.
sudo ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
    
# Change file permissions
sudo chmod a+r /etc/udev/rules.d/51-android.rules
    
# If adbusers group already exists remove old adbusers group
groupdel adbusers
    
# add the adbusers group if it's doesn't already exist
sudo mkdir -p /usr/lib/sysusers.d/ && sudo cp android-udev.conf /usr/lib/sysusers.d/
sudo systemd-sysusers # (if not Ubuntu 16.04 and Mint 18)
    
# if Ubuntu 16.04 and Mint 18
sudo groupadd adbusers
    
# OR on Fedora:
groupadd adbusers
    
# Add your user to the adbusers group (back to Debian again)
sudo usermod -a -G adbusers $(whoami)
    
# Restart UDEV
sudo udevadm control --reload-rules
sudo service udev restart
    
# OR on Fedora:
sudo systemctl restart systemd-udevd.service
    
# Restart the ADB server (back to Debian again)
adb kill-server
    
# Replug your Android device and verify that USB debugging is enabled in developer options
adb devices
    
# You should now see your device
```

## To Contribute:

1. Fork this repository.
2. Make your edits.
3. TEST THEM!
4. Create a pull request.
