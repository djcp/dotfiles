#!/bin/bash

# soundbar_sink=$(pacmd list-sinks | grep 'card:' | grep Sound | cut -d: -f 2 | cut -d' ' -f 2)
action="$1"
amount="2%"

case $action in
  up*)
    direction="+$amount"
    ;;
  *)
    direction="-$amount"
    ;;
esac

if [ "$soundbar_sink" = "" ]; then
  non_soundbar_sink=$(pacmd list-sinks | grep '* index:' | tail -n1 | cut -d: -f 2)
  sink="$non_soundbar_sink"
else
  sink="$soundbar_sink"
fi

pactl set-sink-volume $sink -- "$direction"
