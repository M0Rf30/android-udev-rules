#!/bin/sh

CURRENT_UID="$(id -u)"

if [ "$CURRENT_UID" -ne 0 ]; then
  echo "Please run using sudo!"
  exit 1
fi

if [ "$USE_SYMLINK" = "true" ]; then
  ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
else
  cp -v 51-android.rules /etc/udev/rules.d/51-android.rules
fi
chmod a+r /etc/udev/rules.d/51-android.rules
if [ "$USE_GROUP" = "false" ]; then
  mkdir -p /usr/lib/sysusers.d/ && sudo cp android-udev.conf /usr/lib/sysusers.d/
  systemd-sysusers
else
  groupdel adbusers
  groupadd adbusers
fi

usermod -a -G adbusers "$(logname)"
udevadm control --reload-rules

if [ "$USE_SERVICE_CMD" = "true" ]; then
  service udev restart
else
  systemctl restart systemd-udevd.service
fi
