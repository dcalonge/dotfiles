#!/bin/sh
OUTPUT="HDMI-A-1"
INTERNAL="eDP-1"

if niri msg outputs | grep -q "($OUTPUT)"; then
  echo "$OUTPUT detected, disabling $INTERNAL"
  niri msg output "$INTERNAL" off
  niri msg output "$OUTPUT" on
else
  echo "$OUTPUT not found, using $INTERNAL"
  niri msg output "$INTERNAL" on
fi
