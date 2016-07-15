#!/bin/bash

SEPARATOR_BLOCK_WIDTH=31

set_yubikey_message(){
  yubikey_state=`yubitoggle --state`
  if [ "$?" = '1' ]; then
    yubikey_output=''
  else
    if [ "$yubikey_state" = "0" ]; then
      yubikey_message="off"
      yubikey_color="#ff0000"
    else
      yubikey_message="on"
      yubikey_color="#00ff00"
    fi
    yubikey_output="🔑 $yubikey_message"
  fi
}

insert_json() {
  max_brightness=`cat /sys/class/backlight/intel_backlight/max_brightness`
  current_brightness=`cat /sys/class/backlight/intel_backlight/brightness`

  set_yubikey_message

  WEATHER_JSON=$(cat ~/.cli-weather-forecast)
  brightness=$(echo "scale=2;(100 - (($max_brightness - $current_brightness) \
    / $max_brightness) * 100);" | bc);
  FIXED_LINE="[{\"full_text\": \"$WEATHER_JSON\"}, {\"full_text\": \"$yubikey_output\", \"color\": \"$yubikey_color\"}, {\"full_text\": \
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
