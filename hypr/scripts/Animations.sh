#!/usr/bin/env bash
# Quick animation preset toggle
CURRENT=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [[ "$CURRENT" == "true" ]]; then
  hyprctl keyword animations:enabled false
  notify-send "Animations" "Off"
else
  hyprctl keyword animations:enabled true
  notify-send "Animations" "On"
fi
