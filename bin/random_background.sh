#!/bin/bash

DISPLAY=:0.0 /usr/bin/feh --bg-fill `find ~/Pictures/backgrounds/ -type f -iname '*.jpg' | shuf | head -1`
