#!/usr/bin/env bash
# Ajustes de macOS con defaults (pocos y reversibles: borra la clave con "defaults delete <dominio> <clave>").
# Equivale a gnome/apply.sh en Linux. Se puede ejecutar varias veces.
[ "$(uname)" = Darwin ] || { echo "defaults.sh es solo para macOS."; exit 0; }

# Finder: mostrar todas las extensiones, barra de ruta y barra de estado
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Teclado: repetición rápida de teclas (requiere cerrar sesión para notarse)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
echo "Aviso: la repetición de teclas rápida se aplica al cerrar sesión y volver a entrar."

# Capturas de pantalla en ~/Pictures/Capturas
mkdir -p ~/Pictures/Capturas
defaults write com.apple.screencapture location -string "$HOME/Pictures/Capturas"

# No crear .DS_Store en unidades de red ni USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Reiniciar lo afectado (si no estaba abierto, no pasa nada)
killall Finder SystemUIServer >/dev/null 2>&1 || true
echo "Ajustes de macOS aplicados."
