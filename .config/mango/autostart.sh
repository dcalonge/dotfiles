#!/bin/sh

export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=va_gl
export $(dbus-launch)
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export GRIM_DEFAULT_DIR="/home/daniel/Pictures/Screenshots/"
export PATH="$HOME/.local/bin:$PATH"
export ELECTRON_OZONE_PLATFORM_HINT='auto'
export XDG_CURRENT_DESKTOP=mango
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=mango
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=gtk3
export EDITOR="nvim"

systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP WAYLAND_DISPLAY

waybar &
wl-paste --watch cliphist store &
swaybg -i ~/Pictures/wallpaper &
swayidle -w before-sleep gtklock &
udiskie &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
