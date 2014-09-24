#!/bin/sh
action="$1"

max_brightness=`cat /sys/class/backlight/acpi_video0/max_brightness`
current_brightness=`cat /sys/class/backlight/acpi_video0/brightness`

case $action in
  up*)
    current_brightness=$((current_brightness + 20));
    if [ "$current_brightness" -gt "$max_brightness" ]; then
      current_brightness=$max_brightness;
    fi
    ;;
  down*)
    current_brightness=$((current_brightness - 20));
    if [ "$current_brightness" -lt "0" ]; then
      current_brightness=10;
    fi
    ;;
esac

echo $current_brightness > /sys/class/backlight/acpi_video0/brightness
