#!/bin/sh

# Path to the keybindings HTML file
KEYBINDINGS_FILE="$HOME/scripts/keybindings.html"

# Check if the keybindings file exists
if [ ! -f "$KEYBINDINGS_FILE" ]; then
  zenity --error --text="Keybindings file not found at $KEYBINDINGS_FILE"
  exit 1
fi

# Open the keybindings file in the default web browser
xdg-open "$KEYBINDINGS_FILE"
