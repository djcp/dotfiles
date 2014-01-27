#!/bin/bash

ACTIVE_MONITOR=$(xrandr | grep ' connected' | grep -v 'LVDS1' | cut -f1 -d ' ')

if [ "$ACTIVE_MONITOR" != '' ]; then
  xrandr --output $ACTIVE_MONITOR --auto --off
else
  echo 'No non-LVDS1 monitor connected'
fi
