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
    time SpiderOakONE --batchmode
    ;;
  monthly*)
    time SpiderOakONE --purge-deleted-items=7
    time SpiderOakONE --purge-historical-versions
    time SpiderOakONE --batchmode
    ;;
  *)
    time SpiderOakONE --batchmode
    ;;
esac
