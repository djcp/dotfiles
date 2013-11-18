#!/bin/bash

DATE=`date "+%Y-%m-%dT%H:%M:%S"`
SCREENSHOT_ROOT=~/Pictures/screenshots/
FILE="${SCREENSHOT_ROOT}screenshot-$DATE.png"

mkdir -p $SCREENSHOT_ROOT

import $FILE

gimp $FILE
