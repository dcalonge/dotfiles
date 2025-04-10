#!/bin/sh

if [ "$1" = "up" ]; then
  wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
elif [ "$1" = "down" ]; then
  wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
elif [ "$1" = "mute" ]; then
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol=$(echo "$vol_info" | awk '{print $2 * 100}')
mute=$(echo "$vol_info" | awk '{print $3}')

if [ "$mute" = "[MUTED]" ]; then
  notify-send " Volume Muted" -t 1000 -u low -c "osd-text" --hint=string:x-dunst-stack-tag:osd
else
  notify-send " 󰕾" -t 1000 -u low -h int:value:$vol -c "osd" --hint=string:x-dunst-stack-tag:osd
fi
