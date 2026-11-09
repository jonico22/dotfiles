#!/usr/bin/env bash
set -e
sudo apt install -y git curl gawk fzf zoxide eza bat ripgrep fd-find bash-completion

# Nerd Font
if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
  mkdir -p ~/.local/share/fonts
  wget -qO /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -oq /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
  fc-cache -f
fi



# Starship
command -v starship >/dev/null || curl -sS https://starship.rs/install.sh | sh -s -- -y

# ble.sh
if [ ! -f ~/.local/share/blesh/ble.sh ]; then
  rm -rf /tmp/ble.sh
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git /tmp/ble.sh
  make -C /tmp/ble.sh install PREFIX=~/.local
fi

# Copiar configs (respalda las existentes)
cd "$(dirname "$0")"
[ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak
cp .bashrc ~/.bashrc
mkdir -p ~/.config/ghostty
cp ghostty/config ~/.config/ghostty/config
cp starship/starship.toml ~/.config/starship.toml
echo "Listo. Abre una terminal nueva."
