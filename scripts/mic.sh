#!/bin/sh

send_mic_notification() {
  is_muted=$(pactl list sources | grep -q "Mute: yes" && echo "yes" || echo "no")

  if [ "$is_muted" = "yes" ]; then
    dunstify -t 1000 -u low -i audio-volume-muted "Mic Muted" -h string:fgcolor:#ffffff -h string:bgcolor:#000000 -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace
  else
    dunstify -t 1000 -u low -i audio-volume-medium "Mic Unmuted" -h string:fgcolor:#ffffff -h string:bgcolor:#000000 -h string:x-dunst-stack-tag:volume -h string:x-dunst-stack-mode:replace -h string:hlcolor:#ffffff
  fi
}

# Call function to send notification
send_mic_notification
