#!/usr/bin/env bash
# vm-mode.sh — detect VM and reduce visual effects
if systemd-detect-virt --quiet 2>/dev/null; then
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:active_opacity 1.0
  hyprctl keyword decoration:inactive_opacity 1.0
  hyprctl keyword decoration:dim_inactive false
  hyprctl keyword decoration:rounding 2
  export LIBGL_ALWAYS_SOFTWARE=1
  echo "VM mode: visual effects reduced"
else
  echo "Not in a VM — normal mode"
fi
