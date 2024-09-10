#!/bin/sh

# Function to send volume notification
send_volume_notification() {
  volume_level=$(pactl list sinks | grep 'Volume:' | head -n 1 | awk '{print $5}' | sed 's/%//')

  dunstify -t 1000 -u low -i audio-volume-muted "Volume: $((volume_level))%" -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace -h int:value:$volume_level -h string:hlcolor:"#bbbbbb"

}

# Call function to send notification
send_volume_notification
