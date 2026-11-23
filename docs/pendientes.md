# Pendientes

Resultado de la revisión del 2026-11-22. Lo de macOS ya se corrigió; esto queda pendiente.

## Revisión de Linux (no hecha)

- [ ] Revisar `install.sh`, `files.sh`, `backup.sh`, `gnome/apply.sh`, `packages/*` (`apt.txt`, `flatpak.txt`, `nativas.txt`, `nix/*.txt`, `ollama.txt`, `markitdown.nix`), `systemd/ollama.service` y `wireplumber/`: bugs de bash, paquetes inexistentes o duplicados, archivos que `files.sh` enlaza y no existen o archivos del repo que nunca se instalan.
- [ ] Comprobar que `backup.sh` avisa antes de pisar archivos del repo con los del sistema (docs/07 y README no lo dicen).
- [ ] `.bashrc`: con Nix monousuario solo se carga `nix-daemon.sh`; falta una rama para `~/.nix-profile/etc/profile.d/nix.sh`.
- [ ] Dependencias entre grupos: `install.sh dev` deja LazyVim sin `ripgrep`/`fd`/`fzf` (están en el grupo `terminal`). Documentarlo o moverlos a `base`.

## Documentación

- [ ] docs/06: faltan los alias `bi`, `bs`, `bu` (solo macOS), `v`, `h`, `ver`, y mencionar `.bash_explorar` en la línea de "Definidos en…".
- [ ] docs/06 y README: `desinstalar` también usa brew en macOS; `instalar` maneja `.dmg`/`.pkg`.
- [ ] docs/01: dice que `cat` = `batcat`, el alias real es `bat --paging=never`.
- [ ] README: la línea 3 dice "para desarrollo en Ubuntu" (ya soporta macOS); la tabla "Qué incluye" no lista `ghostty/os` ni `.markdownlint-cli2.yaml`; no menciona `mac/`.
- [ ] docs/README.md: lista los gestores `nix`, `flatpak`, `apt`; falta Homebrew.
- [ ] docs/02 y docs/05: Bruno, DBeaver y CopyQ aparecen como universales; en macOS son Yaak, TablePro y Maccy (comprobar nombres en `mac/Brewfile.*`).
- [ ] docs/08: verificar los atajos de herdr contra la versión instalada (`herdr/config.toml` solo define prefix y popup); quitar la nota "los plugins en negrita son los últimos que agregamos".
- [ ] docs/09: hay datos de una máquina concreta (CPU, RAM, tiempos); "LibreOffice ya viene con Ubuntu" no aplica a macOS.

## Menores de configuración

- [ ] `nvim/lua/plugins/diffview.lua`: `<leader>gh` choca con el prefijo `<leader>gh*` de gitsigns en LazyVim; cambiarlo (p. ej. `<leader>gF`) y actualizar docs/08.
- [ ] `starship.toml`: `[docker_context]` está configurado pero `$docker_context` no está en `format`; `cmd_duration` usa `bg:lavender` tras el cierre powerline.
- [ ] `alias cat=bat` sombrea `cat` (p. ej. `cat -A`); en `.bash_traductor` usar `command cat`.
- [ ] `.bash_traductor`: comprobar que existan `wl-paste`/`pbpaste` y `ollama`, con un mensaje claro.
- [ ] `ulauncher/shortcuts.json`: los iconos están en `/usr/share/ulauncher` (no existe en la instalación sin root); Wikipedia está en inglés y sin búsqueda.
