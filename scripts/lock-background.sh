#!/bin/sh
grim /tmp/lockscreen.png && magick convert -filter Gaussian -resize 20% -blur 0x1 -resize 500% /tmp/lockscreen.png /tmp/lockscreen.png
