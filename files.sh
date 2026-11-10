#!/usr/bin/env bash
# Pares "origen en el sistema:destino en el repo". Un solo lugar para agregar archivos.
# Las rutas del sistema usan $HOME; las del repo son relativas a ~/dotfiles.
FILES=(
  "$HOME/.bashrc:.bashrc"
  "$HOME/.blerc:.blerc"
  "$HOME/.bash_traductor:.bash_traductor"
  "$HOME/.bash_instalar:.bash_instalar"
  "$HOME/.bash_explorar:.bash_explorar"
  "$HOME/.bash_aliases:.bash_aliases"
  "$HOME/.config/glow/estilo.json:glow/estilo.json"
  "$HOME/.config/ghostty/config:ghostty/config"
  "$HOME/.config/starship.toml:starship/starship.toml"
  "$HOME/.config/lazygit/config.yml:lazygit/config.yml"
  "$HOME/.config/ulauncher/settings.json:ulauncher/settings.json"
  "$HOME/.config/ulauncher/shortcuts.json:ulauncher/shortcuts.json"
  "$HOME/.config/ulauncher/extensions.json:ulauncher/extensions.json"
  "$HOME/.config/direnv/direnvrc:direnv/direnvrc"
  "$HOME/.config/nvim/init.lua:nvim/init.lua"
  "$HOME/.config/nvim/lazyvim.json:nvim/lazyvim.json"
  "$HOME/.config/nvim/lua/config/lazy.lua:nvim/lua/config/lazy.lua"
  "$HOME/.config/nvim/lua/config/options.lua:nvim/lua/config/options.lua"
  "$HOME/.config/nvim/lua/config/keymaps.lua:nvim/lua/config/keymaps.lua"
  "$HOME/.config/nvim/lua/config/autocmds.lua:nvim/lua/config/autocmds.lua"
  "$HOME/.config/nvim/lua/plugins/colorscheme.lua:nvim/lua/plugins/colorscheme.lua"
  "$HOME/.config/nvim/lua/plugins/nix.lua:nvim/lua/plugins/nix.lua"
  "$HOME/.config/nvim/lazy-lock.json:nvim/lazy-lock.json"
  "$HOME/.config/herdr/config.toml:herdr/config.toml"
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
