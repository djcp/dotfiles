#!/bin/bash

/usr/bin/feh --bg-fill `find ~/Pictures/backgrounds/ -type f -iname '*.jpg' | shuf | head -1`
