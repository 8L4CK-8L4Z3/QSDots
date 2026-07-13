#!/usr/bin/env bash
# Refresh Quickshell, swaync, and theme
pkill -x qs || true
sleep 0.3
qs &
swaync-client --reload-config 2>/dev/null || true
notify-send "Refreshed" "UI components reloaded"
