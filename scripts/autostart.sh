#!/bin/sh
export ELECTRON_OZONE_PLATFORM_HINT='auto'
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME="qt5ct"

executes="/home/daniel/scripts/bing_wall.sh /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 swayidle wl-paste mako udiskie"
for execute in $executes; do
  case $execute in
  "swayidle") "$execute" -w before-sleep 'pidof -q hyprlock || hyprlock -q' & ;;
  "wl-paste") "$execute" --watch cliphist store & ;;
  *) "$execute" & ;;
  esac
done >/dev/null 2>&1

systemctl --user set-environment XDG_CURRENT_DESKTOP=sway
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP=sway WAYLAND_DISPLAY
exit
