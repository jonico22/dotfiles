#!/usr/bin/env bash
# Instala dependencias y copia repo -> sistema. Se puede ejecutar varias veces.
set -e
cd "$(dirname "$0")"
source ./files.sh
pregunta() { read -rp "$1 [s/N] " r; [[ "$r" =~ ^[sSyY]$ ]]; }

# --- apt ---
sudo apt update
grep -vE '^\s*(#|$)' packages/apt.txt | xargs sudo apt install -y
command -v tldr >/dev/null && tldr --update || true

# --- Nerd Font ---
if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
  mkdir -p ~/.local/share/fonts
  wget -qO /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -oq /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
  fc-cache -f
fi

# --- Starship ---
command -v starship >/dev/null || curl -sS https://starship.rs/install.sh | sh -s -- -y

# --- ble.sh ---
if [ ! -f ~/.local/share/blesh/ble.sh ]; then
  rm -rf /tmp/ble.sh
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git /tmp/ble.sh
  make -C /tmp/ble.sh install PREFIX=~/.local
fi

# --- mise ---
command -v mise >/dev/null || curl -fsS https://mise.run | sh

# --- Zed (instalador oficial) ---
command -v zed >/dev/null || curl -f https://zed.dev/install.sh | sh

# --- Bruno (.deb oficial; la versión de Nix falla por el sandbox de Electron) ---
if ! command -v bruno >/dev/null; then
  v=$(curl -fsSL https://api.github.com/repos/usebruno/bruno/releases/latest | grep -m1 '"tag_name"' | cut -d'"' -f4)
  curl -fsSL -o /tmp/bruno.deb "https://github.com/usebruno/bruno/releases/download/$v/bruno_${v#v}_amd64_linux.deb" \
    && sudo apt install -y /tmp/bruno.deb || echo "Aviso: instala Bruno desde https://www.usebruno.com/downloads"
fi

# --- Flatpak + Flathub ---
if command -v flatpak >/dev/null; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  grep -vE '^\s*(#|$)' packages/flatpak.txt | xargs -r flatpak install -y --noninteractive flathub
fi

# --- Ulauncher (PPA; si falla en esta versión, usar el .deb de GitHub) ---
if ! command -v ulauncher >/dev/null; then
  sudo add-apt-repository -y ppa:agornostal/ulauncher && sudo apt update && sudo apt install -y ulauncher \
    || echo "Aviso: instala Ulauncher con el .deb de https://github.com/Ulauncher/Ulauncher/releases"
fi

# --- Ollama (los modelos pesan GB: se pregunta) ---
command -v ollama >/dev/null || curl -fsSL https://ollama.com/install.sh | sh
if command -v ollama >/dev/null && pregunta "¿Descargar los modelos de Ollama (translategemma:12b 8 GB y :4b 3.3 GB)?"; then
  grep -vE '^\s*(#|$)' packages/ollama.txt | xargs -rn1 ollama pull
fi

# --- Nix ---
if command -v nix >/dev/null; then
  faltan=$(grep -vE '^\s*(#|$)' packages/nix.txt | while read -r p; do
    nix profile list 2>/dev/null | grep -q "legacyPackages.x86_64-linux.$p\$\|/$p\$" || echo "$p"; done)
  if [ -n "$faltan" ]; then
    echo "Paquetes Nix que faltan:"; echo "$faltan"
    if pregunta "¿Instalarlos?"; then
      for p in $faltan; do nix profile install "nixpkgs#$p" || echo "Aviso: falló $p"; done
    fi
  fi
else
  echo "Aviso: Nix no está instalado; se omiten los paquetes Nix (https://nixos.org/download)."
fi

# --- Copiar configs (respalda las existentes como .bak) ---
for par in "${FILES[@]}"; do
  src="${par%%:*}"; dst="${par#*:}"
  [ -f "$dst" ] || { echo "Aviso: falta $dst en el repo"; continue; }
  mkdir -p "$(dirname "$src")"
  if [ -f "$src" ] && ! cmp -s "$src" "$dst"; then cp "$src" "$src.bak"; fi
  cp "$dst" "$src"
done

# --- GNOME ---
bash gnome/apply.sh

echo "Listo. Abre una terminal nueva (y cierra sesión si las apps Nix/Flatpak no aparecen en el menú)."
