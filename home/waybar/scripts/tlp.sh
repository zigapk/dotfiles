#!/usr/bin/env bash
#
# tlp-toggle.sh
# Usage:
#   tlp-toggle.sh        # prints current icon
#   tlp-toggle.sh toggle # toggles profile and signals Waybar

# which RTMIN offset to use (must match your "signal" in Waybar)
SIG=7

# get raw mode string ("AC" or "BAT"); strip everything after the first word
mode=$(tlp-stat -s 2>/dev/null |
  awk -F'= ' '/^Mode/ {print $2}' |
  awk '{print $1}')

if [[ $1 == "toggle" ]]; then
  if [[ $mode == "AC" ]]; then
    sudo tlp bat
  else
    sudo tlp ac
  fi
  # notify Waybar to refresh this module
  kill -SIGRTMIN+$SIG $(pidof waybar) 2>/dev/null
  exit
fi

# only print the icon
if [[ $mode == "AC" ]]; then
  echo "🏎️"
else
  echo "🦥"
fi
