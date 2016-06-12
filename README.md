## Description
These rules refer to http://developer.android.com/guide/developing/device.html and include many suggestions from the Archlinux and Github Community.

If you're developing on Ubuntu Linux, you need to add a udev rules file that contains a USB configuration for each type of device you want to use for development. In the rules file, each device manufacturer is identified by a unique vendor ID, as specified by the ATTR{idVendor} property. For a list of vendor IDs, see USB Vendor IDs, below.

Use this format to add each vendor to the file(example vendor ID is for HTC):  
`SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"`

The MODE assignment specifies read/write permissions, and GROUP defines which Unix group owns the device node.

Note: The rule syntax may vary slightly depending on your environment. Consult the udev documentation for your system as needed. For an overview of rule syntax, see this guide to writing udev rules. please refer to 51-android.rules in [ubuntu directory](ubuntu)

## Installation

#### For Ubuntu

```sh
# Clone the repo (replace repo-url with the Github URL)
git clone <repo-url>
# Create a sym-link to the rules file
sudo ln -s `pwd`/android-udev-rules/51-android.rules /etc/udev/rules.d/
# Change file permissions
sudo chmod a+r /etc/udev/rules.d/51-android.rules
# Restart UDEV
sudo udevadm control --reload-rules
sudo service udev restart
# Add plugdev group to your <login-id>
sudo usermod -a -G plugdev <login-id>
# Repluging your Android and verify adb is enabled in developer options
# Restart ADB server
adb kill-server
adb devices
# You should now see your device
```

## Troubleshooting
Try group plug**in**dev rather than plugdev, then restart udev.

## To Contribute:

1. Please fork this repository
2. Make your edits
3. TEST IT!
4. Create a pull-request

## Note

Some devices (particularly MediaTek and Xiaomi) also require an entry in $HOME/.android/adb\_usb.ini. You can use the adb_usb.ini
  
`ln -s `pwd`/adb_usb.ini $HOME/.android/

