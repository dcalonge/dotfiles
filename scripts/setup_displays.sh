#!/bin/sh

INTERNAL="eDP-1"

if wlr-randr | grep -q '(HDMI-A-1)'; then
  EXTERNAL="HDMI-A-1"
elif wlr-randr | grep -q '(DP-1)'; then
  EXTERNAL="DP-1"
else
  EXTERNAL=""
fi

if [ -n "$EXTERNAL" ]; then
  echo "$EXTERNAL detected, disabling $INTERNAL"
  wlr-randr --output "$INTERNAL" --off
  wlr-randr --output "$EXTERNAL" --on
else
  echo "No external display found, using $INTERNAL"
  wlr-randr --output "$INTERNAL" --on
fi
