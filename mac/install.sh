#!/usr/bin/env bash
# Instala los dotfiles en macOS por grupos, con Homebrew (sin Nix). Todo va en tu usuario.
# Lo llama ./install.sh del repo; es compatible con el bash 3.2 que trae macOS.
# Uso: ./install.sh [grupo ...|todo]   Sin grupos: pregunta uno por uno.
# Se puede ejecutar varias veces: lo ya instalado se salta.
set -e
SCRIPT="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"
cd "$(dirname "$SCRIPT")/.."
source ./files.sh
GRUPOS=(terminal dev ia documentos multimedia escritorio)
pregunta() { read -rp "$1 [s/N] " r; [[ "$r" =~ ^[sSyY]$ ]]; }
AVISOS=()
aviso() { echo "Aviso: $*"; AVISOS+=("$*"); }
# Carpeta temporal propia (no rutas fijas en /tmp); se borra al salir.
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

# --- Argumentos ---
elegidos=()
for a in "$@"; do
  case "$a" in
    -h|--help) sed -n '2,5p' "$SCRIPT" | sed 's/^# //'; echo "Grupos: ${GRUPOS[*]}"; exit 0 ;;
    todo) elegidos=("${GRUPOS[@]}") ;;
    *) [[ " ${GRUPOS[*]} " == *" $a "* ]] || { echo "Grupo desconocido: $a (grupos: ${GRUPOS[*]}, todo)"; exit 1; }
       elegidos+=("$a") ;;
  esac
done
quiere() { [[ " ${elegidos[*]} " == *" $1 "* ]]; }

[ "$(id -u)" -eq 0 ] && { echo "No ejecutes install.sh con sudo ni como root: se instala en tu usuario."; exit 1; }

# --- Homebrew ---
cargar_brew() {
  local b
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$b" ] && { eval "$("$b" shellenv)"; return 0; }
  done
  return 0
}
command -v brew >/dev/null || cargar_brew
if ! command -v brew >/dev/null; then
  if ! id -Gn | grep -qw admin; then
    aviso "Homebrew no está instalado y tu usuario no es administrador: pide a un admin que lo instale (https://brew.sh); por ahora solo se copian las configs."
  elif pregunta "Homebrew no está instalado. ¿Instalarlo con el script oficial de brew.sh? (pide sudo)"; then
    curl -fsSL -o "$tmp/brew-install" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    /bin/bash "$tmp/brew-install" || aviso "falló la instalación de Homebrew"
    cargar_brew
  fi
fi
# Si la app ya se instaló a mano, que brew la adopte en vez de fallar
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:+$HOMEBREW_CASK_OPTS }--adopt"
if command -v brew >/dev/null; then hay_brew=si; else
  hay_brew=no
  aviso "Homebrew no está disponible: solo se copian las configs, no se instalan programas."
fi

# --- Elegir grupos ---
if [ ${#elegidos[@]} -eq 0 ]; then
  echo "¿Qué quieres instalar? (las configs y lo básico se instalan siempre)"
  for g in "${GRUPOS[@]}"; do
    pregunta "  $g: $(sed -n '1s/^# //p' "mac/Brewfile.$g")?" && elegidos+=("$g")
  done
fi
echo "Grupos: base ${elegidos[*]}"

# Instala con Homebrew lo de mac/Brewfile.<grupo>; si falla, avisa y sigue.
brew_grupo() {
  [ "$hay_brew" = si ] || return 0
  echo "[$1] Homebrew: mac/Brewfile.$1"
  brew bundle --file="mac/Brewfile.$1" </dev/null || aviso "falló brew bundle ($1): revisa mac/Brewfile.$1"
}

# === base (siempre) ===
brew_grupo base
# ble.sh (autosugerencias) no está en brew: método oficial en ~/.local (necesita git, make y gawk)
if [ ! -f ~/.local/share/blesh/ble.sh ]; then
  if command -v git >/dev/null && command -v make >/dev/null && command -v gawk >/dev/null; then
    { git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git "$tmp/ble.sh" \
        && make -C "$tmp/ble.sh" install PREFIX=~/.local; } || aviso "falló ble.sh"
  else
    aviso "faltan git, make o gawk: no se instala ble.sh"
  fi
fi
[ "$hay_brew" = no ] && [ ! -f ~/.local/share/blesh/ble.sh ] \
  && aviso "sin Homebrew no se instalan starship ni ble.sh (la terminal funciona igual, más simple)"

# === terminal ===
if quiere terminal; then
  brew_grupo terminal
  command -v tldr >/dev/null && { tldr --update >/dev/null 2>&1 || true; }
fi

# === dev ===
if quiere dev; then
  brew_grupo dev   # Python: mise use -g python
fi

# === ia ===
if quiere ia; then
  brew_grupo ia
  # Ollama: si ya está (por ejemplo Ollama.app) no se duplica; si no, brew + servicio de tu usuario.
  if ! command -v ollama >/dev/null && [ ! -d /Applications/Ollama.app ] && [ "$hay_brew" = si ]; then
    brew install ollama || aviso "falló Ollama"
  fi
  if command -v ollama >/dev/null && [ "$hay_brew" = si ] && brew list ollama >/dev/null 2>&1 \
     && ! ollama list >/dev/null 2>&1; then
    brew services start ollama || aviso "no se pudo iniciar Ollama (prueba: ollama serve)"
    for _ in 1 2 3 4 5 6 7 8 9 10; do ollama list >/dev/null 2>&1 && break; sleep 1; done
  fi
  # Modelos: pesan GB, se pregunta por cada uno. packages/ollama.txt: "modelo  # tamaño"
  if command -v ollama >/dev/null; then
    grep -vE '^[[:space:]]*(#|$)' packages/ollama.txt | while read -r m _ tam; do
      pregunta "¿Descargar el modelo $m ($tam)?" < /dev/tty && ollama pull "$m" < /dev/null
    done || true
  fi
  # MLX solo existe en Apple Silicon
  if [ "$(uname -m)" = arm64 ] && [ "$hay_brew" = si ] && ! command -v mlx_lm.generate >/dev/null \
     && pregunta "¿mlx-lm (modelos MLX de Hugging Face, opcional; Ollama ya usa MLX)?"; then
    brew install mlx-lm || aviso "falló mlx-lm"
  fi
  # Estos no están en brew: instalador oficial (curl | sh, en tu usuario).
  echo "Los siguientes usan el instalador oficial de cada proyecto (se descarga y ejecuta un script; sin sudo):"
  if ! command -v claude >/dev/null && pregunta "  ¿Claude Code? (se actualiza solo)"; then
    curl -fsSL https://claude.ai/install.sh | bash || aviso "falló Claude Code"
  fi
  if ! command -v agy >/dev/null && pregunta "  ¿Antigravity CLI (agy, de Google)?"; then
    curl -fsSL https://antigravity.google/cli/install.sh | bash || aviso "falló Antigravity CLI"
    # Su instalador añade ~/.local/bin al PATH en .bashrc, .profile y .bash_profile aunque ya esté: se quita el duplicado.
    for _f in ~/.bashrc ~/.profile ~/.bash_profile; do
      [ -f "$_f" ] && awk '/^# Added by Antigravity CLI installer$/ {skip=2} skip>0 {skip--; next} 1' "$_f" > "$_f.tmp" \
        && cat "$_f.tmp" > "$_f"; rm -f "$_f.tmp"
    done
  fi
  # OpenCode 1 (la 2 aún tiene fallos). Para pasar a la 2: opencode upgrade --major
  if ! command -v opencode >/dev/null && pregunta "  ¿OpenCode 1?"; then
    mkdir -p ~/.local/bin
    curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path \
      && ln -sfn ~/.opencode/bin/opencode ~/.local/bin/opencode || aviso "falló OpenCode"
  fi
fi

# === documentos ===
if quiere documentos; then
  brew_grupo documentos
  if command -v uv >/dev/null; then
    command -v docling >/dev/null || uv tool install docling || aviso "falló docling"
    command -v markitdown >/dev/null || uv tool install "markitdown[all]" || aviso "falló markitdown"
  else
    aviso "falta uv: no se instalan docling ni markitdown"
  fi
fi

# === multimedia ===
if quiere multimedia; then
  brew_grupo multimedia
fi

# === escritorio ===
if quiere escritorio; then
  brew_grupo escritorio
  # Elgato (opcional, solo si tienes Stream Deck o micrófono Wave)
  if [ "$hay_brew" = si ] && pregunta "¿Tienes Stream Deck o micrófono Elgato Wave? (instala Stream Deck y Wave Link)"; then
    brew install --cask elgato-stream-deck || aviso "falló Elgato Stream Deck"
    brew install --cask elgato-wave-link || aviso "falló Elgato Wave Link (exige macOS 15 o superior)"
  fi
  if pregunta "¿Aplicar ajustes de macOS (mac/defaults.sh)?"; then
    bash mac/defaults.sh || aviso "fallaron los ajustes de macOS"
  fi
fi

# --- Ghostty usa el bash de Homebrew: se ajusta la ruta de ghostty/macos al prefijo real ---
prefijo=/opt/homebrew
[ "$hay_brew" = si ] && prefijo="$(brew --prefix)"

# === Copiar configs (siempre; respalda las existentes como .bak) ===
for par in "${FILES[@]}"; do
  src="${par%%:*}"; dst="${par#*:}"
  [ -f "$dst" ] || { aviso "falta $dst en el repo"; continue; }
  mkdir -p "$(dirname "$src")"
  if [ "$dst" = ghostty/macos ]; then
    # Sin Homebrew no hay bash 5: se usa /bin/bash en vez de una ruta inexistente
    if [ "$hay_brew" = si ]; then sed "s|/opt/homebrew|$prefijo|" "$dst" > "$tmp/os"
    else
      aviso "sin Homebrew, Ghostty usará /bin/bash"
      sed "s|/opt/homebrew/bin/bash|/bin/bash|" "$dst" > "$tmp/os"
    fi
    dst="$tmp/os"
  fi
  if [ -f "$src" ] && ! cmp -s "$src" "$dst"; then cp "$src" "$src.bak"; fi
  cp "$dst" "$src"
done

# Plugins de LazyVim fijados en lazy-lock.json (necesita ~/.config/nvim ya copiado)
if quiere dev && command -v nvim >/dev/null; then
  echo "[dev] Neovim: instalando plugins (lazy-lock.json)"
  nvim --headless "+Lazy! restore" +qa </dev/null || aviso "falló la instalación de plugins de Neovim (se instalarán al abrir nvim)"
fi

echo
if [ ${#AVISOS[@]} -gt 0 ]; then
  echo "Terminado con ${#AVISOS[@]} aviso(s):"; printf '  - %s\n' "${AVISOS[@]}"
else
  echo "Listo, sin avisos."
fi
echo "Abre una terminal nueva (Ghostty)."
