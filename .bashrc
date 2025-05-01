export GRIM_DEFAULT_DIR="/home/daniel/Pictures/"

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  export BEMENU_OPTS='-W 0.3 -c -l 15 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#eeeeee" --tb "#000000" --ff "#eeeeee" --fb "#000000" --cf "#eeeeee" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#eeeeee" --hb "#000000" --fbf "#eeeeee" --fbb "#000000" --sf "#eeeeee" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
  # exec hyprland
  while true; do
    someblocks | dwl -s /home/daniel/scripts/autostart.sh >~/.dwl.log 2>&1
  done
  exit
fi
