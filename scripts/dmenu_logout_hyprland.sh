#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | bemenu)" in
suspend) systemctl suspend ;;
logout) hyprctl dispatch exit ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
