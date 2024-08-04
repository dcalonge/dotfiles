#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | rofi -dmenu)" in
suspend) systemctl suspend ;;
logout) swaymsg exit ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
