#!/usr/bin/env python3
# ~/.config/matugen/papirus-folders/change-icons.py

import sys
import os
import colorsys
import subprocess

COLOR_FILE = os.path.expanduser(
    os.path.join(os.environ.get("XDG_CONFIG_HOME", "~/.config"),
                 "matugen/papirus-folders/folder-color.txt")
)
PAPIRUS_THEME = os.environ.get("PAPIRUS_THEME", "Papirus")

COLORS = {
    "adwaita":    "#93c0ea",
    "black":      "#4f4f4f",
    "blue":       "#5294e2",
    "bluegrey":   "#607d8b",
    "breeze":     "#57b8ec",
    "brown":      "#ae8e6c",
    "carmine":    "#a30002",
    "cyan":       "#00bcd4",
    "darkcyan":   "#45abb7",
    "deeporange": "#eb6637",
    "green":      "#87b158",
    "grey":       "#8e8e8e",
    "indigo":     "#5c6bc0",
    "magenta":    "#f754a4",
    "nordic":     "#5e81ac",
    "orange":     "#e7822a",
    "palebrown":  "#c5a88b",
    "paleorange": "#f5a04a",
    "pink":       "#f06292",
    "red":        "#e03535",
    "teal":       "#009688",
    "violet":     "#7b52ae",
    "white":      "#d4d4d4",
    "yaru":       "#e95420",
    "yellow":     "#f9a825",
}

def hex_to_hls(h):
    h = h.lstrip("#")
    r, g, b = int(h[0:2], 16) / 255, int(h[2:4], 16) / 255, int(h[4:6], 16) / 255
    return colorsys.rgb_to_hls(r, g, b)  # (hue, lightness, saturation)

def hue_dist(h1, h2):
    d = abs(h1 - h2)
    return min(d, 1.0 - d)

def nearest_color(target_hex):
    th, tl, ts = hex_to_hls(target_hex)
    return min(
        COLORS,
        key=lambda name: (
            hue_dist(th, hex_to_hls(COLORS[name])[0]) * 2.0
            + abs(ts - hex_to_hls(COLORS[name])[2]) * 0.5
            + abs(tl - hex_to_hls(COLORS[name])[1]) * 0.3
        )
    )

def main():
    if not os.path.exists(COLOR_FILE):
        print(f"change-icons: color file not found: {COLOR_FILE}", file=sys.stderr)
        sys.exit(1)

    target_hex = open(COLOR_FILE).read().strip()

    if not target_hex.lstrip("#").isalnum() or len(target_hex.lstrip("#")) != 6:
        print(f"change-icons: invalid hex value: '{target_hex}'", file=sys.stderr)
        sys.exit(1)

    nearest = nearest_color(target_hex)
    print(f"change-icons: {target_hex} → {nearest} (theme: {PAPIRUS_THEME})")
    subprocess.run(["papirus-folders", "-C", nearest, "-t", PAPIRUS_THEME], check=True)

if __name__ == "__main__":
    main()
