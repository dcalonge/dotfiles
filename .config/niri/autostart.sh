#!/bin/sh

waybar &
wl-paste --watch cliphist store &
mako &
swaybg -i ~/Pictures/wallpaper &
swayidle -w before-sleep gtklock &
udiskie &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
