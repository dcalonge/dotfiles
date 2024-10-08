#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | bemenu)" in
suspend) systemctl suspend ;;
logout) riverctl exit ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
