#!/usr/bin/env bash
# Toggle animations on/off (game mode)
CURRENT=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [[ "$CURRENT" == "true" ]]; then
  hyprctl keyword animations:enabled false
  notify-send "Game Mode" "Animations OFF"
else
  hyprctl keyword animations:enabled true
  notify-send "Game Mode" "Animations ON"
fi
