#!/bin/sh

if [ "$1" = "up" ]; then
  brightnessctl set +5%
elif [ "$1" = "down" ]; then
  brightnessctl set 5%-
fi

max_brightness=$(brightnessctl max)

if [ "$max_brightness" -gt 0 ]; then
  brightness_percent=$(($(brightnessctl get) * 100 / max_brightness))
else
  brightness_percent=0
fi

kill -54 $(pidof i3status-rs)

notify-send " 󰃟" -t 1000 -u low -h int:value:$brightness_percent -c "osd" --hint=string:x-dunst-stack-tag:osd
