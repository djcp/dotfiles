#!/bin/sh
action="$1"

max_brightness=`cat /sys/class/backlight/intel_backlight/max_brightness`
current_brightness=`cat /sys/class/backlight/intel_backlight/brightness`
increment=50

case $action in
  up*)
    current_brightness=$((current_brightness + $increment));
    if [ "$current_brightness" -gt "$max_brightness" ]; then
      current_brightness=$max_brightness;
    fi
    ;;
  down*)
    current_brightness=$((current_brightness - $increment));
    if [ "$current_brightness" -lt "0" ]; then
      current_brightness=10;
    fi
    ;;
esac

echo $current_brightness > /sys/class/backlight/intel_backlight/brightness
