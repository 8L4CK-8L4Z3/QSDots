#!/usr/bin/env bash
# Toggle between dwindle and master layout
CURRENT=$(hyprctl getoption general:layout | awk 'NR==1{print $2}')
if [[ "$CURRENT" == "dwindle" ]]; then
  hyprctl keyword general:layout master
  notify-send "Layout" "Master"
else
  hyprctl keyword general:layout dwindle
  notify-send "Layout" "Dwindle"
fi
