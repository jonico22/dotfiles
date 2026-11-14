#!/usr/bin/env bash
# Instala los dotfiles por grupos. Todo va en tu usuario: Nix, ~/.local y Flatpak --user.
# sudo solo se usa (modo con root) para instalar Nix la primera vez y lo mínimo de apt.
# Uso: ./install.sh [--sin-root|--con-root] [grupo ...|todo]   Sin grupos: pregunta uno por uno.
# Se puede ejecutar varias veces: lo ya instalado se salta.
set -e
cd "$(dirname "$0")"
source ./files.sh
GRUPOS=(terminal dev ia documentos multimedia escritorio)
pregunta() { read -rp "$1 [s/N] " r; [[ "$r" =~ ^[sSyY]$ ]]; }
AVISOS=()
aviso() { echo "Aviso: $*"; AVISOS+=("$*"); }
# Carpeta temporal propia (no rutas fijas en /tmp); se borra al salir.
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

# --- Argumentos ---
root=auto; elegidos=()
for a in "$@"; do
  case "$a" in
    --sin-root) root=no ;;
    --con-root) root=si ;;
    -h|--help) sed -n '2,5p' "$0" | sed 's/^# //'; echo "Grupos: ${GRUPOS[*]}"; exit 0 ;;
    todo) elegidos=("${GRUPOS[@]}") ;;
    *) [[ " ${GRUPOS[*]} " == *" $a "* ]] || { echo "Grupo desconocido: $a (grupos: ${GRUPOS[*]}, todo)"; exit 1; }
       elegidos+=("$a") ;;
  esac
done
quiere() { [[ " ${elegidos[*]} " == *" $1 "* ]]; }

[ "$(id -u)" -eq 0 ] && { echo "No ejecutes install.sh con sudo ni como root: se instala en tu usuario."; exit 1; }

# --- ¿Con root o sin root? ---
if [ "$root" = auto ]; then
  if id -nG | grep -qwE 'sudo|admin|wheel'; then root=si; else root=no; fi
fi
if [ "$root" = si ]; then
  echo "Modo con root: sudo se usará solo para apt y para instalar Nix si falta."
  sudo -v || { aviso "sudo no funcionó: sigo en modo sin root"; root=no; }
else
  echo "Modo sin root: no se usará sudo."
fi

# --- Elegir grupos ---
if [ ${#elegidos[@]} -eq 0 ]; then
  echo "¿Qué quieres instalar? (las configs y lo básico se instalan siempre)"
  for g in "${GRUPOS[@]}"; do
    pregunta "  $g: $(sed -n '1s/^# //p' "packages/nix/$g.txt")?" && elegidos+=("$g")
  done
fi
echo "Grupos: base ${elegidos[*]}"

# --- apt (solo con root: lo mínimo del sistema) ---
if [ "$root" = si ] && command -v apt >/dev/null; then
  sudo apt update
  grep -vE '^\s*(#|$)' packages/apt.txt | xargs sudo apt install -y
  if quiere escritorio; then sudo apt install -y gnome-shell-extension-manager || aviso "falló gnome-shell-extension-manager"; fi
fi

# --- Nix ---
export NIX_CONFIG="experimental-features = nix-command flakes"
cargar_nix() {
  local f
  for f in /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ~/.nix-profile/etc/profile.d/nix.sh; do
    [ -e "$f" ] && . "$f"
  done
  return 0
}
command -v nix >/dev/null || cargar_nix
if ! command -v nix >/dev/null && [ "$root" = si ]; then
  if pregunta "Nix no está instalado. ¿Instalarlo con el instalador oficial de nixos.org? (pide sudo una vez)"; then
    curl --proto '=https' --tlsv1.2 -fsSL -o "$tmp/nix-install" https://nixos.org/nix/install
    sh "$tmp/nix-install" --daemon
    cargar_nix
  fi
fi
if command -v nix >/dev/null; then hay_nix=si; else
  hay_nix=no
  aviso "Nix no está disponible: solo se copian las configs, no se instalan programas."
  [ "$root" = no ] && aviso "Sin root no se puede instalar Nix: pide a un admin que lo instale (https://nixos.org/download) y vuelve a ejecutar install.sh."
fi

# Instala con Nix, en tu perfil, los paquetes de packages/nix/<grupo>.txt que falten.
# SALTAR="a b" excluye paquetes (p. ej. si ya están instalados de otra forma).
nix_grupo() {
  local g="$1" p faltan=() lista unfree=0
  [ "$hay_nix" = si ] || return 0
  lista="$(nix profile list 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g')"
  while read -r p; do
    [[ " ${SALTAR:-} " == *" $p "* ]] && continue
    grep -qE "legacyPackages\.[^.]+\.${p}\$" <<<"$lista" || faltan+=("$p")
  done < <(grep -vE '^\s*(#|$)' "packages/nix/$g.txt")
  [ ${#faltan[@]} -eq 0 ] && return 0
  echo "[$g] Nix: ${faltan[*]}"
  # docling depende de un paquete no libre (saxonche): solo se permite en "documentos".
  local extra=(); [ "$g" = documentos ] && { unfree=1; extra=(--impure); }
  # Todo junto (una descarga); si falla, uno por uno para saber cuál.
  NIXPKGS_ALLOW_UNFREE=$unfree nix profile add "${extra[@]}" "${faltan[@]/#/nixpkgs#}" && return 0
  for p in "${faltan[@]}"; do
    NIXPKGS_ALLOW_UNFREE=$unfree nix profile add "${extra[@]}" "nixpkgs#$p" || aviso "falló Nix: $p"
  done
}

# nixGL: las apps gráficas de Nix lo necesitan fuera de NixOS (OpenGL).
nixgl() {
  [ "$hay_nix" = si ] || return 0
  command -v nixGL >/dev/null || nix profile add --impure github:nix-community/nixGL || aviso "falló nixGL"
}

# Flatpak en tu usuario (--user): sin sudo y sin remotos de sistema.
flatpak_user() {
  local app
  command -v flatpak >/dev/null || { aviso "falta flatpak (se instala con apt en modo con root): se omite $*"; return 0; }
  flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  for app in "$@"; do
    flatpak info "$app" >/dev/null 2>&1 && continue
    flatpak install --user -y --noninteractive flathub "$app" || aviso "falló Flatpak: $app"
  done
}

# === base (siempre) ===
nix_grupo base
if [ "$hay_nix" = no ] && [ ! -f ~/.local/share/blesh/ble.sh ]; then
  aviso "sin Nix no se instalan starship ni ble.sh (la terminal funciona igual, más simple)"
fi
# Fuente con íconos para el prompt (en ~/.local/share/fonts)
if ! fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd"; then
  if command -v curl >/dev/null && command -v unzip >/dev/null; then
    mkdir -p ~/.local/share/fonts
    curl -fsSL -o "$tmp/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
      && unzip -oq "$tmp/JetBrainsMono.zip" -d ~/.local/share/fonts/JetBrainsMono && fc-cache -f \
      || aviso "falló la fuente JetBrainsMono Nerd"
  else
    aviso "faltan curl o unzip: no se instala la fuente JetBrainsMono Nerd"
  fi
fi

# === terminal ===
if quiere terminal; then
  nix_grupo terminal
  command -v tldr >/dev/null && { tldr --update >/dev/null 2>&1 || true; }
  if ! command -v ghostty >/dev/null; then
    if [ "$root" = si ] && apt-cache show ghostty >/dev/null 2>&1; then
      sudo apt install -y ghostty || aviso "falló Ghostty (apt)"   # la de Ubuntu no necesita nixGL
    elif [ "$hay_nix" = si ]; then
      nix profile add nixpkgs#ghostty && nixgl || aviso "falló Ghostty (Nix)"
    else
      aviso "no se pudo instalar Ghostty (ni apt ni Nix)"
    fi
  fi
fi

# === dev ===
if quiere dev; then
  nix_grupo dev
  nixgl                                  # zed, lapce, meld y dbeaver son gráficas
  flatpak_user com.usebruno.Bruno        # la versión de Nix falla por el sandbox de Electron
fi

# === ia ===
if quiere ia; then
  # Si Ollama ya está instalado de otra forma (servicio del sistema), no se duplica.
  if command -v ollama >/dev/null && [ ! -x ~/.nix-profile/bin/ollama ]; then SALTAR=ollama nix_grupo ia; else nix_grupo ia; fi
  # Ollama de Nix como servicio de tu usuario (sin root)
  if [ -x ~/.nix-profile/bin/ollama ] && command -v systemctl >/dev/null \
     && ! systemctl is-active -q ollama 2>/dev/null; then
    mkdir -p ~/.config/systemd/user
    cp systemd/ollama.service ~/.config/systemd/user/ollama.service
    systemctl --user daemon-reload
    systemctl --user enable --now ollama || aviso "no se pudo iniciar Ollama (prueba: ollama serve)"
    for _ in 1 2 3 4 5 6 7 8 9 10; do ollama list >/dev/null 2>&1 && break; sleep 1; done
  fi
  # Modelos: pesan GB, se pregunta por cada uno. packages/ollama.txt: "modelo  # tamaño"
  if command -v ollama >/dev/null; then
    grep -vE '^\s*(#|$)' packages/ollama.txt | while read -r m _ tam; do
      pregunta "¿Descargar el modelo $m ($tam)?" < /dev/tty && ollama pull "$m" < /dev/null
    done || true
  fi
  # Estos no están en nixpkgs en la versión que se usa aquí: instalador oficial (curl | sh, en tu usuario).
  echo "Los siguientes usan el instalador oficial de cada proyecto (se descarga y ejecuta un script; sin sudo):"
  if ! command -v claude >/dev/null && pregunta "  ¿Claude Code? (se actualiza solo)"; then
    curl -fsSL https://claude.ai/install.sh | bash || aviso "falló Claude Code"
  fi
  if ! command -v agy >/dev/null && pregunta "  ¿Antigravity CLI (agy, de Google)?"; then
    curl -fsSL https://antigravity.google/cli/install.sh | bash || aviso "falló Antigravity CLI"
    # Su instalador añade ~/.local/bin al PATH en .bashrc y .profile aunque ya esté: se quita el duplicado.
    sed -i '/^# Added by Antigravity CLI installer$/,+1d' ~/.bashrc ~/.profile 2>/dev/null || true
  fi
  # OpenCode 1 (la 2, que es la de nixpkgs, aún tiene fallos). Para pasar a la 2: opencode upgrade --major
  if ! command -v opencode >/dev/null && pregunta "  ¿OpenCode 1?"; then
    mkdir -p ~/.local/bin
    curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path \
      && ln -sfn ~/.opencode/bin/opencode ~/.local/bin/opencode || aviso "falló OpenCode"
  fi
fi

# === documentos ===
if quiere documentos; then
  nix_grupo documentos
  # markitdown con soporte de PDF/Word/PowerPoint/Excel (el de nixpkgs viene sin esos extras)
  if [ "$hay_nix" = si ] && ! command -v markitdown >/dev/null; then
    nix profile add --impure -I nixpkgs=flake:nixpkgs --file packages/markitdown.nix || aviso "falló markitdown"
  fi
fi

# === multimedia ===
if quiere multimedia; then
  nix_grupo multimedia
  nixgl
fi

# === escritorio ===
if quiere escritorio; then
  nix_grupo escritorio
  nixgl
  mapfile -t apps < <(grep -vE '^\s*(#|$)' packages/flatpak.txt)
  [ ${#apps[@]} -gt 0 ] && flatpak_user "${apps[@]}"
  # Elgato (opcional, solo si tienes Stream Deck o micrófono Wave). Ver docs/10-elgato.md
  if pregunta "¿Tienes Stream Deck o micrófono Elgato Wave? (instala OpenDeck y Pipeweaver)"; then
    flatpak_user me.amankhanna.opendeck
    # Pipeweaver no está en Flathub: se instala desde el repo del autor, en tu usuario.
    if command -v flatpak >/dev/null && ! flatpak info io.github.pipeweaver >/dev/null 2>&1; then
      flatpak install --user -y https://github.com/pipeweaver/pipeweaver/releases/latest/download/pipeweaver.flatpakref \
        || aviso "falló Pipeweaver"
    fi
  fi
  bash gnome/apply.sh   # ajustes de GNOME con dconf (en tu usuario)
fi

# === Copiar configs (siempre; respalda las existentes como .bak) ===
for par in "${FILES[@]}"; do
  src="${par%%:*}"; dst="${par#*:}"
  [ -f "$dst" ] || { aviso "falta $dst en el repo"; continue; }
  mkdir -p "$(dirname "$src")"
  if [ -f "$src" ] && ! cmp -s "$src" "$dst"; then cp "$src" "$src.bak"; fi
  cp "$dst" "$src"
done

echo
if [ ${#AVISOS[@]} -gt 0 ]; then
  echo "Terminado con ${#AVISOS[@]} aviso(s):"; printf '  - %s\n' "${AVISOS[@]}"
else
  echo "Listo, sin avisos."
fi
echo "Abre una terminal nueva (y cierra sesión si las apps de Nix/Flatpak no aparecen en el menú)."
