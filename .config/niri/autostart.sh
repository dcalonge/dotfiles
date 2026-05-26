#!/bin/sh

pipewire &
pipewire-pulse &
wireplumber &

~/scripts/setup_displays.sh

waybar &
wl-paste --watch cliphist store &
mako &
swaybg -i ~/Pictures/wallpaper.jpg &
swayidle -w before-sleep swaylock &
devmon --exec-on-drive "notify-send 'Mounted to /media: %f'" &
/usr/libexec/polkit-gnome-authentication-agent-1 &
