#!/bin/bash

HOST="nimbus.io"
COUNT=5

count=$(ping -c $COUNT $HOST | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
if [ $count -eq 0 ]; then
  # 100% failed
  echo "$HOST is down, not backing up.";
  exit;
fi

action="$1"

case $action in
  hourly*)
    time SpiderOak --batchmode
    ;;
  monthly*)
    time SpiderOak --purge-deleted-items=7
    time SpiderOak --purge-historical-versions
    time SpiderOak --batchmode
    ;;
  *)
    time SpiderOak --batchmode
    ;;
esac
