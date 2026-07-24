#!/bin/sh
OPTIONS="update\nexit"
SELECTION=$(printf "$OPTIONS" | fuzzel --dmenu)

case "$SELECTION" in
"update")
  foot -e bash -c 'paru && flatpak update -y && echo "" && read -p "Press return to close"'
  ;;
esac
