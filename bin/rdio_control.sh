#!/bin/sh

action="$1"

case $action in
  pause*)
    key_to_send="space"
    ;;
  next*)
    key_to_send="ctrl+Right"
    ;;
  previous*)
    key_to_send="ctrl+Left"
    ;;
  *)
    key_to_send="space"
    ;;
esac

current_window=$(xdotool getwindowfocus)
xdotool search --name "Rdio|A Soft Murmur|Google Play Music|Spotify Player" windowactivate --sync -- \
  key "$key_to_send" \
  windowactivate "$current_window"
