#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | bemenu)" in
suspend) systemctl suspend ;;
logout) loginctl terminate-user daniel ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
