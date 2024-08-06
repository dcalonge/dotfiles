#!/bin/bash

# Function to send brightness notification
send_brightness_notification() {
  local brightness_level=$(brightnessctl -m | grep -oP ',[0-9]+,(\d{1,3}%),' | cut -d '%' -f1 | cut -d ',' -f3)

  dunstify -t 1000 -u low -i audio-volume-muted "Brightness" -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace -h int:value:$brightness_level -h string:fgcolor:#ffffff -h string:hlcolor:"#ffffff" -h string:bgcolor:#000000
}

# Call function to send notification
send_brightness_notification
