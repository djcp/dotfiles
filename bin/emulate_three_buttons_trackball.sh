#!/bin/bash

ID=`xinput list | grep Logitech | sed "s/.*id=\([0-9]*\).*/\1/g"`

xinput --set-prop $ID 'Evdev Middle Button Emulation' 1
