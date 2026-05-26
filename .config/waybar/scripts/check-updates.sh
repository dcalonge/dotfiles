#!/bin/sh

# Timeout in seconds
TIMEOUT=10

# XBPS updates (with timeout)
if command -v timeout >/dev/null 2>&1; then
  xbps_pkgs=$(timeout "$TIMEOUT" xbps-install -nuM 2>/dev/null | awk '{print $1}')
else
  xbps_pkgs=$(xbps-install -nuM 2>/dev/null | awk '{print $1}')
fi

# Flatpak updates (with timeout, only if installed)
if command -v flatpak >/dev/null 2>&1; then
  if command -v timeout >/dev/null 2>&1; then
    flatpak_pkgs=$(timeout "$TIMEOUT" flatpak remote-ls --updates --columns=application 2>/dev/null)
  else
    flatpak_pkgs=$(flatpak remote-ls --updates --columns=application 2>/dev/null)
  fi
else
  flatpak_pkgs=""
fi

# Combine lists
all_pkgs=$(printf '%s\n%s\n' "$xbps_pkgs" "$flatpak_pkgs" | sed '/^$/d')

# Count
pkg_count=$(printf '%s\n' "$all_pkgs" | grep -c .)

# Tooltip formatting
pkg_list=$(printf '%s\n' "$all_pkgs" | sed '/^$/d; s/$/\\r/' | tr -d '\n')

# Output JSON

printf '{"text":"󰏕 %s", "tooltip":"%s"}\n' "$pkg_count" "$pkg_list"
