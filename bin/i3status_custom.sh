#!/bin/bash

SEPARATOR_BLOCK_WIDTH=31

insert_json() {
  max_brightness=`cat /sys/class/backlight/intel_backlight/max_brightness`
  current_brightness=`cat /sys/class/backlight/intel_backlight/brightness`

  WEATHER_JSON=$(cat ~/.cli-weather-forecast)
  brightness=$(echo "scale=2;(100 - (($max_brightness - $current_brightness) \
    / $max_brightness) * 100);" | bc);
  FIXED_LINE="[{\"full_text\": \"$WEATHER_JSON\"}, {\"full_text\": \
    \"💡 $brightness\"}, $@,"
}

insert_separator_width() {
  FIXED_LINE=$(echo $FIXED_LINE | sed "s/{/{\"separator_block_width\": \
    $SEPARATOR_BLOCK_WIDTH, /g")
}

i3status | while :
do
  read LINE

  if echo "$LINE" | grep -qiE 'name'
  then
    FIXED_LINE=$(echo $LINE | sed '0,/\[/ s/,*\[//')
    insert_json $FIXED_LINE
    insert_separator_width $FIXED_LINE

    echo $FIXED_LINE
  else
    echo $LINE
  fi
done
