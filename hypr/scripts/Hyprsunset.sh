#!/usr/bin/env bash
# Toggle Hyprsunset (night light)
if pkill -0 hyprsunset 2>/dev/null; then
  pkill hyprsunset
  notify-send "Night Light" "Off"
else
  hyprsunset --temperature 3500 &
  notify-send "Night Light" "On (3500K)"
fi
