#!/usr/bin/env bash
# Carga la configuración de GNOME guardada en gnome/*.ini y activa extensiones.
cd "$(dirname "$0")" || exit 1
source ../files.sh
command -v dconf >/dev/null || { echo "Aviso: dconf no disponible"; exit 0; }
for p in "${GNOME_PATHS[@]}"; do
  f="$(gnome_nombre "$p")"
  [ -f "$f" ] && dconf load "$p" < "$f"
done
# Extensiones (Tactile y Auto Move Windows se instalan desde el Gestor de extensiones)
if [ -f extensions.txt ] && command -v gnome-extensions >/dev/null; then
  while read -r e; do
    [ -n "$e" ] && { gnome-extensions enable "$e" 2>/dev/null || echo "Aviso: extensión no instalada: $e"; }
  done < extensions.txt
fi
