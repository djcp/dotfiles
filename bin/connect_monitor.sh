#!/bin/bash

CONNECTED_MONITOR=$(xrandr | grep ' connected' | grep -vE 'LVDS1|eDP1' | cut -f1 -d ' ')
LAPTOP_PANEL=$(xrandr | grep ' connected' | grep -E 'LVDS1|eDP1' | cut -f1 -d ' ')
ORIENTATION_OPTION=''

# right-of left-of above below

if [ "$CONNECTED_MONITOR" != '' ]; then

  echo
  echo "Activate $CONNECTED_MONITOR relative to LVDS1 or eDP1 where?"
  echo
  echo "1) right-of (default)"
  echo "2) left-of"
  echo "3) above"
  echo "4) below"
  echo -n '> '

  read ORIENTATION

  case $ORIENTATION in
    1)
      ORIENTATION_OPTION="right-of"
      ;;
    2)
      ORIENTATION_OPTION="left-of"
      ;;
    3)
      ORIENTATION_OPTION="above"
      ;;
    4)
      ORIENTATION_OPTION="below"
      ;;
    *)
      ORIENTATION_OPTION="right-of"
      ;;
  esac

  xrandr --output $CONNECTED_MONITOR --auto --$ORIENTATION_OPTION $LAPTOP_PANEL
else
  echo 'No non-LVDS1 monitor connected'
fi

~/bin/emulate_three_buttons_trackball.sh
