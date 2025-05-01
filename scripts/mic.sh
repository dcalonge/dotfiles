#!/bin/sh

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
kill -49 $(pidof i3status-rs)
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "[MUTED]"; then
  notify-send " Mic Muted" -t 1000 -u low -c "osd-text" --hint=string:x-dunst-stack-tag:osd
else
  notify-send " Mic Unmuted" -t 1000 -u low -c "osd-text" --hint=string:x-dunst-stack-tag:osd
fi
