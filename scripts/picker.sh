#!/bin/bash

export BEMENU_OPTS='-W 0.3 -c -l 15 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#eeeeee" --tb "#000000" --ff "#eeeeee" --fb "#000000" --cf "#eeeeee" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#eeeeee" --hb "#000000" --fbf "#eeeeee" --fbb "#000000" --sf "#eeeeee" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
monitors=$(wlr-randr --json | jq '.[] | .name')
windows="${XDPH_WINDOW_SHARING_LIST}"

result=""

# Add monitors to result
while IFS= read -r monitor; do
  monitor=$(echo "$monitor" | tr -d '"') # Remove quotes from monitor name
  if [ -n "$result" ]; then
    result="${result}\n"
  fi
  result="${result}${monitor}\tscreen: ${monitor}"
done <<<"$monitors"

# Add region entry
if [ -n "$result" ]; then
  result="${result}\n"
fi
result="${result}region\tSelection Region"

# Add windows to result
while IFS= read -r line; do
  if [ -n "$result" ]; then
    result="${result}\n"
  fi
  result="${result}${line}"
done < <(echo "$windows" | awk -F'\\[HE>\\]' '{
    for(i=1; i<=NF; i++) {
        if ($i == "") continue;

        split($i, window, "\\[HC>\\]");
        id = window[1];

        split(window[2], parts, "\\[HT>\\]");
        class = parts[1];
        title = parts[2];

        if (id != "")
            print id "\t" "window: " title;
    }
}')

selection=$(echo -e "$result" | bemenu)

if [[ $selection == *"screen"* ]]; then
  monitor=$(echo "$selection" | cut -f1)
  echo "[SELECTION]/screen:${monitor}"
elif [[ $selection == *"window"* ]]; then
  window_id=$(echo "$selection" | cut -f1)
  echo "[SELECTION]/window:${window_id}"
elif [[ $selection == *"region"* ]]; then
  region=$(slurp -f "%o@%x,%y,%w,%h")
  echo "[SELECTION]/region:${region}"
fi
