# android-udev-rules

## Description

These rules refer to [Run Apps on a Hardware Device - Android Studio](https://developer.android.com/studio/run/device.html) and include many suggestions from the Archlinux and Github Communities.


## Installation

### Arch

On Arch it should be enough to follow the [instructions for connecting a device on the Arch wiki](https://wiki.archlinux.org/index.php/android#Connect_device). There's no need to clone this repository.


### Ubuntu

    # Clone this repository
    git clone https://github.com/M0Rf30/android-udev-rules.git
    # Copy rules file
    sudo cp -v ./android-udev-rules/51-android.rules /etc/udev/rules.d/51-android.rules
    # OR oreate a sym-link to the rules file - choose this option if you'd like to update your udev rules using git.
    sudo ln -sf $PWD/android-udev-rules/51-android.rules /etc/udev/rules.d/51-android.rules
    # Change file permissions
    sudo chmod a+r /etc/udev/rules.d/51-android.rules
    # If adbusers group already exists remove old adbusers group
    groupdel adbusers
    # add the adbusers group if it's doesn't already exist
    sudo cp android-udev.conf to /usr/lib/sysusers.d/
    sudo systemd-sysusers
    # Add your user to the adbusers group
    sudo usermod -a -G adbusers $(whoami)
    # Restart UDEV
    sudo udevadm control --reload-rules
    sudo service udev restart
    # Restart the ADB server
    adb kill-server
    # Replug your Android device and verify that USB debugging is enabled in developer options
    adb devices
    # You should now see your device


## To Contribute:

1. Fork this repository.
2. Make your edits.
3. TEST THEM!
4. Create a pull request.


## Note

Some devices (particularly MediaTek and Xiaomi) additionally require an entry in `$HOME/.android/adb_usb.ini`. You can use the adb_usb.ini from this repository:

    ln -s `pwd`/adb_usb.ini $HOME/.android/
