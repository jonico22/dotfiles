#!/usr/bin/env bash
# Copia sistema -> repo, regenera listas y hace commit + push.
cd "$(dirname "$0")" || exit 1
source ./files.sh

for par in "${FILES[@]}"; do
  src="${par%%:*}"; dst="${par#*:}"
  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dst")"; cp "$src" "$dst"
  else
    echo "Aviso: no existe $src (se omite)"
  fi
done

# GNOME
mkdir -p gnome
if command -v dconf >/dev/null; then
  for p in "${GNOME_PATHS[@]}"; do
    out="gnome/$(gnome_nombre "$p")"
    dconf dump "$p" > "$out"
    [ -s "$out" ] || rm -f "$out"
  done
  command -v gnome-extensions >/dev/null && gnome-extensions list --enabled > gnome/extensions.txt
fi

# Listas de paquetes
mkdir -p packages
# Nix: las listas van por grupos (packages/nix/*.txt) y se mantienen a mano.
# Aquí solo se avisa de lo instalado que no está en ningún grupo.
if command -v nix >/dev/null; then
  sinlista=$(comm -23 \
    <(nix profile list 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' \
        | sed -nE 's/.*legacyPackages\.[^.]+\.([^ ]+)$/\1/p' | sort -u) \
    <(cat packages/nix/*.txt | grep -vE '^\s*(#|$)' | sort -u))
  [ -n "$sinlista" ] && echo "Aviso: paquetes Nix instalados que no están en ningún grupo de packages/nix/ (añádelos al que toque):" \
    && echo "$sinlista" | sed 's/^/  /'
fi
# Homebrew (macOS): lo mismo, contra mac/Brewfile.*
if [ "$(uname)" = Darwin ] && command -v brew >/dev/null; then
  sinbrew=$(comm -23 \
    <({ brew leaves --installed-on-request; brew list --cask; } 2>/dev/null | sort -u) \
    <({ cat mac/Brewfile.* | sed -nE 's/^(brew|cask) "([^"]+)".*/\2/p'
        # los que install.sh instala aparte (Ollama, MLX, Elgato)
        printf '%s\n' ollama mlx-lm elgato-stream-deck elgato-wave-link; } | sort -u))
  [ -n "$sinbrew" ] && echo "Aviso: programas de Homebrew instalados que no están en ningún mac/Brewfile.* (añádelos al que toque):" \
    && echo "$sinbrew" | sed 's/^/  /'
fi
command -v flatpak >/dev/null && flatpak list --app --columns=application > packages/flatpak.txt
command -v ollama >/dev/null && ollama list | awk 'NR>1{print $1"  # "$3" "$4}' | sort > packages/ollama.txt
# apt.txt se mantiene a mano

# Solo se añaden las rutas conocidas (no "git add ." para no subir archivos sueltos).
rutas=()
for d in gnome packages mac "${FILES[@]#*:}"; do
  # git add falla entero si una ruta no existe ni está versionada
  { [ -e "$d" ] || git ls-files --error-unmatch -- "$d" >/dev/null 2>&1; } && rutas+=("$d")
done
git add -A -- "${rutas[@]}"
git diff --cached --quiet && { echo "Sin cambios."; exit 0; }
git diff --cached --stat

# Busca posibles secretos en lo que se va a subir.
if git diff --cached -U0 | grep -E '^\+' \
   | grep -nEi '(sk-[A-Za-z0-9_-]{16,}|ghp_[A-Za-z0-9]{20,}|github_pat_|AKIA[0-9A-Z]{16}|xox[abp]-|-----BEGIN [A-Z ]*PRIVATE KEY|(api[_-]?key|secret|token|password)["'\'' ]*[:=])'; then
  echo "¡Ojo! Lo de arriba parece un secreto. Revísalo antes de subir."
fi

read -rp "¿Hacer commit y push? [s/N] " r
[[ "$r" =~ ^[sSyY]$ ]] || { echo "Cancelado (los cambios quedan en el índice)."; exit 0; }
git commit -m "Actualización $(date +%F)" && git push
