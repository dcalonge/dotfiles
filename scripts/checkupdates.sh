#!/bin/sh
TIMEOUT=10

xbps=$(timeout "$TIMEOUT" xbps-install -nuM 2>/dev/null | wc -l)

flatpak=0
command -v flatpak >/dev/null 2>&1 &&
  flatpak=$(timeout "$TIMEOUT" flatpak remote-ls --updates --columns=application 2>/dev/null | wc -l)

printf '%s\n' $((xbps + flatpak))
