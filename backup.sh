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
command -v nix >/dev/null && nix profile list --json 2>/dev/null \
  | python3 -c "import json,sys; e=json.load(sys.stdin)['elements']; print('\n'.join(sorted(e) if isinstance(e,dict) else sorted(x.get('attrPath','').split('.')[-1] for x in e)))" > packages/nix.txt
command -v flatpak >/dev/null && flatpak list --app --columns=application > packages/flatpak.txt
command -v ollama >/dev/null && ollama list | awk 'NR>1{print $1}' > packages/ollama.txt
# apt.txt se mantiene a mano

git add .
git commit -m "Actualización $(date +%F)" && git push
