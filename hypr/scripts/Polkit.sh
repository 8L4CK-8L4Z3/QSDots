#!/usr/bin/env bash
# Start the appropriate polkit authentication agent
if command -v /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &>/dev/null; then
  /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
elif command -v /usr/lib/polkit-kde-authentication-agent-1 &>/dev/null; then
  /usr/lib/polkit-kde-authentication-agent-1
fi
