#!/bin/sh

grim /tmp/lockscreen.png && ffmpeg -i /tmp/lockscreen.png -vf "boxblur=3:3" /tmp/lockscreen_tmp.png && mv /tmp/lockscreen_tmp.png /tmp/lockscreen.png
