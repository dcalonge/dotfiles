#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | bemenu)" in
suspend) systemctl suspend ;;
logout) pkill -x someblocks && pkill -x dwl ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
