# android-udev-rules

## Description

These rules refer to
[Run Apps on a Hardware Device - Android Studio](https://developer.android.com/studio/run/device.html)
and include many suggestions from the Archlinux and Github Communities.

## Installation

### Arch

On Arch it should be enough to follow the
[instructions for connecting a device on the Arch wiki](https://wiki.archlinux.org/index.php/Android_Debug_Bridge).
There's no need to clone this repository.

### Other distros

The following instructions assume that you're using a GNU/Linux distro with
systemd

```sh
# Clone this repository
git clone https://github.com/M0Rf30/android-udev-rules.git
cd android-udev-rules
    
# Copy rules file
sudo cp -v 51-android.rules /etc/udev/rules.d/51-android.rules
    
# OR create a sym-link to the rules file - choose this option if you'd like to
# update your udev rules using git.
sudo ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
    
# Change file permissions
sudo chmod a+r /etc/udev/rules.d/51-android.rules
    
# Add the adbusers group if it's doesn't already exist
sudo cp android-udev.conf /usr/lib/sysusers.d/
sudo systemd-sysusers

# Add your user to the adbusers group
sudo gpasswd -a $(whoami) adbusers
    
# Restart UDEV
sudo udevadm control --reload-rules
sudo systemctl restart systemd-udevd.service
   
# Restart the ADB server (back to Debian again)
adb kill-server
    
# Replug your Android device and verify that USB debugging is enabled in
# developer options
adb devices
    
# You should now see your device
```

## To Contribute

1. Fork this repository.
2. Make your edits.
3. TEST THEM!
4. Create a pull request.
