#!/bin/sh

executes="/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 swayidle wl-paste mako udiskie swaybg"
for execute in $executes; do
  case $execute in
  "swayidle") "$execute" -w before-sleep 'pidof -q hyprlock || hyprlock -q' & ;;
  "wl-paste") "$execute" --watch cliphist store & ;;
  "swaybg") "$execute" -i ~/Pictures/wallpaper.jpg & ;;
  *) "$execute" & ;;
  esac
done >/dev/null 2>&1

systemctl --user set-environment XDG_CURRENT_DESKTOP=sway
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP=sway WAYLAND_DISPLAY

wlr-randr --output eDP-1 --adaptive-sync enabled
bluetoothctl power off
exit
