#!/bin/sh

# Definir las opciones del menú
OPTIONS="update\nexit"

# Mostrar el menú usando rofi
SELECTION=$(echo "$OPTIONS" | bemenu)

# Función para actualizar pacman y flatpak
update_system() {
  # Ejecutar los comandos de actualización en una sub-shell
  foot -e bash -c 'paru && flatpak update && read -p "pulsa enter para cerrar"'
}

# Tomar acción según la selección del usuario
case "$SELECTION" in
"update")
  update_system
  ;;
esac
