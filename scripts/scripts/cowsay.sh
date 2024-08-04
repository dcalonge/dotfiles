#! /bin/bash
if type shuf > /dev/null; then
  cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
else
  cowfiles=( $(cowsay -l | sed "1 d") );
  cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
cowsay -f "$cowfile"
