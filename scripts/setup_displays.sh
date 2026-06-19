#!/bin/sh

INTERNAL="eDP-1"

if niri msg outputs | grep -q '(HDMI-A-1)'; then
  EXTERNAL="HDMI-A-1"
elif niri msg outputs | grep -q '(DP-1)'; then
  EXTERNAL="DP-1"
else
  EXTERNAL=""
fi

if [ -n "$EXTERNAL" ]; then
  echo "$EXTERNAL detected, disabling $INTERNAL"
  niri msg output "$INTERNAL" off
  niri msg output "$EXTERNAL" on
else
  echo "No external display found, using $INTERNAL"
  niri msg output "$INTERNAL" on
fi
