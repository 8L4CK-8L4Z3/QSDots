#!/usr/bin/env bash
# Switch keyboard layout (us <-> fr)
CURRENT=$(hyprctl getoption input:kb_layout | awk 'NR==1{print $2}')
if [[ "$CURRENT" == "us" ]]; then
  hyprctl keyword input:kb_layout fr
  notify-send "Keyboard Layout" "FR"
else
  hyprctl keyword input:kb_layout us
  notify-send "Keyboard Layout" "US"
fi
