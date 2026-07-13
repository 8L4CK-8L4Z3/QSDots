#!/usr/bin/env bash
# Toggle a drop-down terminal
TERMINAL="${1:-ghostty}"
CLASS="ghostty-dropterm"

if hyprctl clients -j | jq -e ".[] | select(.class == \"$CLASS\")" >/dev/null 2>&1; then
  hyprctl dispatch closewindow "class:^$CLASS$"
else
  $TERMINAL --class "$CLASS"
fi
