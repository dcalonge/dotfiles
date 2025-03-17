#!/bin/sh

executes="/home/daniel/scripts/bing_wall.sh swayidle wl-paste dunst"
for execute in $executes; do
  case $execute in
  "swayidle") "$execute" -w before-sleep 'pidof -q hyprlock || hyprlock -q' & ;;
  "wl-paste") "$execute" --watch cliphist store & ;;
  *) "$execute" & ;;
  esac
done >/dev/null 2>&1

systemctl --user set-environment XDG_CURRENT_DESKTOP=sway
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

hash dbus-update-activation-environment 2>/dev/null
exec dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP=sway WAYLAND_DISPLAY
