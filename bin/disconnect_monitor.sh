#!/bin/bash

CONNECTED_MONITOR=$(xrandr | grep ' connected' | grep -vE 'LVDS1|eDP1|DP-3' | cut -f1 -d ' ')

if [ "$CONNECTED_MONITOR" != '' ]; then
  xrandr --output $CONNECTED_MONITOR --auto --off
else
  echo 'No non-LVDS1 or eDP1 monitor connected'
fi
