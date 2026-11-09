#!/usr/bin/env bash
# Pares "origen en el sistema:destino en el repo". Un solo lugar para agregar archivos.
# Las rutas del sistema usan $HOME; las del repo son relativas a ~/dotfiles.
FILES=(
  "$HOME/.bashrc:.bashrc"
  "$HOME/.blerc:.blerc"
  "$HOME/.bash_traductor:.bash_traductor"
  "$HOME/.bash_instalar:.bash_instalar"
  "$HOME/.bash_explorar:.bash_explorar"
  "$HOME/.config/glow/estilo.json:glow/estilo.json"
  "$HOME/.config/ghostty/config:ghostty/config"
  "$HOME/.config/starship.toml:starship/starship.toml"
  "$HOME/.config/lazygit/config.yml:lazygit/config.yml"
  "$HOME/.config/ulauncher/settings.json:ulauncher/settings.json"
  "$HOME/.config/ulauncher/shortcuts.json:ulauncher/shortcuts.json"
  "$HOME/.config/ulauncher/extensions.json:ulauncher/extensions.json"
  "$HOME/.config/direnv/direnvrc:direnv/direnvrc"
)
# Rutas dconf a versionar (gnome/<nombre>.ini)
GNOME_PATHS=(
  /org/gnome/mutter/
  /org/gnome/desktop/wm/preferences/
  /org/gnome/desktop/wm/keybindings/
  /org/gnome/shell/keybindings/
  /org/gnome/settings-daemon/plugins/media-keys/
  /org/gnome/shell/extensions/auto-move-windows/
  /org/gnome/shell/extensions/tactile/
  /org/gnome/shell/extensions/tiling-assistant/
)
gnome_nombre() { local n="${1#/}"; n="${n%/}"; echo "${n//\//_}.ini"; }
