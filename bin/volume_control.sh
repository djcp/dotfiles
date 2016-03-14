#!/bin/bash

running_sink=$(pacmd list-sinks | grep 'state: RUNNING' -B 10 | grep 'index: ' | cut -d: -f 2)
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

if [ "$running_sink" = "" ]; then
  non_running_sink=$(pacmd list-sinks | grep 'index:' | tail -n1 | cut -d: -f 2)
  sink="$non_running_sink"
else
  sink="$running_sink"
fi

pactl set-sink-volume $sink -- "$direction"
