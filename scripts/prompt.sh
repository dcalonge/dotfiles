#!/bin/sh
OPTIONS="update\nexit"
SELECTION=$(printf "$OPTIONS" | fuzzel --dmenu)

case "$SELECTION" in
"update")
  foot -e bash -c 'doas xbps-install -Suy && flatpak update -y && echo "" && read -p "Pulsa enter para cerrar"'
  ;;
esac
