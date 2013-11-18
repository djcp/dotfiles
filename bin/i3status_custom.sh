#!/bin/sh

i3status | while :
do
        read line
        echo "`cat ~/.cli-weather-forecast` | $line" || exit 1
done
