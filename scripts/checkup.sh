#!/bin/sh

# Verificar actualizaciones de paquetes Arch Linux
arch_updates=$(checkupdates | wc -l)

# Verificar actualizaciones de aplicaciones flatpak
flatpak_updates=$(/usr/bin/flatpak remote-ls --columns=application -a --updates | wc -l)

num_updates=$((arch_updates + flatpak_updates))

echo -n "  $num_updates"
