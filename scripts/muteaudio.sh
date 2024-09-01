#!/bin/sh

# Function to send volume notification
send_volume_notification() {
  is_muted=$(pactl list sinks | grep "Mute:" | awk '{print $2}')
  volume_level=$(pactl list sinks | grep "Volume: " | awk 'NR==1{print $5}' | sed 's/%//')

  if [ "$is_muted" = "yes" ]; then
    dunstify -t 1000 -u low -i audio-volume-muted "Volume Muted" -h int:value:0 -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace
  else
    dunstify -t 1000 -u low -i audio-volume-medium "Volume Unmuted" -h int:value:$volume_level -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace -h string:hlcolor:#eeeeee

  fi
}

# Toggle mute/unmute

# Call function to send notification
send_volume_notification
