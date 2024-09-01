#!/bin/sh

killall someblocks

dbus-update-activation-environment --systemd SEATD_SOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
syestemctl --user import-environment SEATD_SOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway

executes="swaybg swayidle /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 wl-paste dunst someblocks"
for execute in $executes; do
  pidof -q "$execute" && continue
  case $execute in
  "swaybg") "$execute" -i ~/Pictures/montain.webp -m fill & ;;
  "swayidle") "$execute" -w before-sleep 'pidof -q hyprlock || hyprlock -q' & ;;
  "wl-paste") "$execute" --watch cliphist store & ;;
  *) "$execute" & ;;
  esac
done >/dev/null 2>&1
