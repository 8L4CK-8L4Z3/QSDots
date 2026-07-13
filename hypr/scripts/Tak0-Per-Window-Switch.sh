#!/usr/bin/env bash
# Per-window keyboard layout switch (stub)
# Uses hyprctl switchxkblayout
ACTIVE=$(hyprctl activewindow -j | jq -r '.workspace.id // empty' 2>/dev/null)
if [[ -z "$ACTIVE" ]]; then
  hyprctl switchxkblayout "$(hyprctl activewindow -j | jq -r '.address')" next
fi
notify-send "Keyboard" "Per-window layout switched"
