#!/bin/bash

ACTIVE_MONITOR=$(xrandr | grep ' connected' | grep -v 'LVDS1' | cut -f1 -d ' ')
ORIENTATION_OPTION=''

# right-of left-of above below

if [ "$ACTIVE_MONITOR" != '' ]; then

  echo
  echo "Activate $ACTIVE_MONITOR relative to LVDS1 where?"
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

  xrandr --output $ACTIVE_MONITOR --auto --$ORIENTATION_OPTION LVDS1
else
  echo 'No non-LVDS1 monitor connected'
fi
