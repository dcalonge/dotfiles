#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | rofi -dmenu -p "Elige una opción:")" in
suspend) systemctl suspend ;;
logout) swaymsg exit ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
