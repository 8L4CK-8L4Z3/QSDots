#!/usr/bin/env bash
# Toggle blur on/off
CURRENT=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')
if [[ "$CURRENT" == "true" ]]; then
  hyprctl keyword decoration:blur:enabled false
  notify-send "Blur" "Off"
else
  hyprctl keyword decoration:blur:enabled true
  notify-send "Blur" "On"
fi
