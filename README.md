# 🖥️ Dotfiles — Terminal Ghostty + Bash

Mi configuración de terminal para desarrollo en Ubuntu.

## 📦 Qué incluye

| Archivo | Ubicación real | Descripción |
|---|---|---|
| `.bashrc` | `~/.bashrc` | Configuración de Bash, alias e integraciones |
| `ghostty/config` | `~/.config/ghostty/config` | Tema, fuente y transparencia de Ghostty |
| `starship/starship.toml` | `~/.config/starship.toml` | Prompt con colores (Catppuccin Powerline) |
| `.blerc` | `~/.blerc` | Enter ejecuta incluso en modo multilínea |
| `.bash_traductor` | `~/.bash_traductor` | Funciones `traducir` y `tr4` (Ollama) |
| `.bash_instalar` | `~/.bash_instalar` | Funciones `instalar` y `desinstalar` |
| `.bash_explorar` | `~/.bash_explorar` | Funciones `arbol`, `explorar` y `md` |
| `.bash_aliases` | `~/.bash_aliases` | Alias cortos: `nixi`, `nixs`, `lg`, `agi`, `da`... |
| `nvim/` | `~/.config/nvim/` | Neovim con LazyVim (LSP, buscador, git, diffview, Claude Code; Catppuccin) |
| `herdr/config.toml` | `~/.config/herdr/config.toml` | herdr: paneles, sesiones y agentes (prefijo `Ctrl+a`) |
| `glow/estilo.json` | `~/.config/glow/estilo.json` | Estilo de glow para Markdown (sin los `#` en los títulos) |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` | delta como pager |
| `ulauncher/*.json` | `~/.config/ulauncher/` | Preferencias, atajos web y extensiones |
| `direnv/direnvrc` | `~/.config/direnv/direnvrc` | Activa nix-direnv |
| `wireplumber/51-elgato-wave.conf` | `~/.config/wireplumber/wireplumber.conf.d/` | **Opcional:** micrófono Elgato Wave estable. Ver [docs/10](docs/10-elgato.md) |
| `gnome/*.ini` | dconf | Escritorios, atajos y extensiones de GNOME |
| `packages/nix/*.txt` | — | Paquetes Nix por grupo (terminal, dev, ia…) |
| `packages/*.txt` | — | apt (solo con root), Flatpak y modelos de Ollama |
| `systemd/ollama.service` | `~/.config/systemd/user/` | Ollama como servicio de tu usuario (grupo ia) |
| `files.sh` | — | Lista única de archivos usada por `backup.sh` e `install.sh` |

## 🛠️ Programas, por grupos

`install.sh` instala por **grupos**: tú eliges cuáles. Casi todo viene de **Nix** y se instala
en tu usuario (`~/.nix-profile`), sin sudo. Cada lista está en `packages/nix/<grupo>.txt`.

| Grupo | Qué trae |
|---|---|
| **base** (siempre) | Copia las configs · [Starship](https://starship.rs) (prompt) · [ble.sh](https://github.com/akinomyoga/ble.sh) (autosugerencias) · [JetBrainsMono Nerd Font](https://www.nerdfonts.com) |
| **terminal** | [Ghostty](https://ghostty.org) (apt) · fzf · zoxide · eza · bat · ripgrep · fd · btop · tldr · glow · jq / yq · dust / duf · hyperfine · direnv + nix-direnv · [herdr](https://github.com/herdrdev/herdr) · wl-clipboard · translate-shell |
| **dev** | git · gh · lazygit · delta · neovim (+ gcc, tree-sitter, nil, nixfmt) · nodejs · pnpm · python3 · mise · just · xh · hurl · posting · lazydocker · podman · meld · dbeaver · [Zed](https://zed.dev) (instalador oficial) · [Bruno](https://www.usebruno.com) (Flatpak) |
| **ia** | codex · [Ollama](https://ollama.com) como servicio de tu usuario + modelos (pregunta uno por uno, ~22 GB en total) · y, si dices que sí, Claude Code, agy y OpenCode 1 con su instalador oficial |
| **documentos** | pandoc · imagemagick · ghostscript · poppler · qpdf · ocrmypdf + tesseract · exiftool · 7zz / unar · ffmpeg · docling · markitdown |
| **multimedia** | mpv · yt-dlp · easyeffects · qpwgraph |
| **escritorio** | Ajustes de GNOME (dconf) · [Ulauncher](https://ulauncher.io) · CopyQ · Flatpak de `packages/flatpak.txt` (Dialect) · Elgato opcional ([docs/10](docs/10-elgato.md)) |

Notas sobre algunos paquetes:

| Paquete | Nota |
|---|---|
| Ghostty | Solo nativo: con root se instala con apt. No se usa la de Nix (fuera de NixOS da problemas de interfaz/OpenGL). Sin root, `install.sh` avisa |
| Zed | Nativo con su instalador oficial (`~/.local/bin/zed`, sin sudo). No se usa el de Nix por el mismo motivo |
| nixGL | Las apps gráficas de Nix (meld, dbeaver, mpv…) lo necesitan fuera de NixOS. Si una abre con errores de OpenGL: `nixGL <app>` |
| direnv + nix-direnv | Al entrar a una carpeta de proyecto carga solo sus variables `.env` y su entorno de Nix, y al salir los descarga |
| docling | PDFs con tablas, columnas y fórmulas a Markdown (~1,4 GB de RAM, ~8 s por página con CPU). Depende de un paquete no libre: `install.sh` lo permite **solo** en el grupo documentos |
| markitdown | PDF, Word, Excel y PowerPoint a Markdown. Se instala con `packages/markitdown.nix` (el de nixpkgs viene sin soporte de PDF/Office) |
| Ollama | El de Nix usa CPU. Si ya tienes Ollama instalado de otra forma (por ejemplo con GPU), no se toca |
| codex | Codex CLI de OpenAI; usa la sesión de la app de ChatGPT en `~/.codex`. Actualizar: `nix profile upgrade codex` |

## 🤖 Agentes de IA en la terminal

| Comando | Proveedor | Instalación | Actualizar |
|---|---|---|---|
| `claude` | Anthropic (Claude Code) | Instalador nativo (`~/.local/bin`) | Solo |
| `codex` | OpenAI (Codex CLI) | Nix | `nix profile upgrade codex` |
| `agy` | Google (Antigravity CLI) | Instalador oficial (`~/.local/bin`) | Solo |
| `opencode` | Varios proveedores (OpenCode 1) | Instalador oficial (`~/.opencode/bin`) | `opencode upgrade` |

- Ninguno usa sudo. `codex` se instala con Nix en el grupo **ia**; para los otros tres `install.sh` pregunta, porque usan el instalador oficial (descarga y ejecuta un script).
- **Gemini CLI no se instala:** desde el 18-06-2026 la cuenta gratuita y los planes Google AI Pro/Ultra solo funcionan en `agy`.
- **Primera vez:** `codex` usa la sesión de la app de ChatGPT; `agy` pide iniciar sesión con Google; `opencode` trae modelos gratis y con `opencode auth login` se agregan otros proveedores.

## ⌨️ Atajos y alias

| Comando / Atajo | Acción |
|---|---|
| `→` | Aceptar autosugerencia (ble.sh) |
| `Ctrl+R` | Buscar en el historial (fzf) |
| `Ctrl+T` | Buscar archivos (fzf) |
| `Alt+C` | Entrar a una carpeta buscando (fzf) |
| `z <nombre>` | Saltar a una carpeta visitada antes |
| `ll` | Listar todo con detalles y estado git |
| `tree` | Ver árbol de carpetas |
| `cat` | Ver archivo con colores (bat) |
| `gs` | `git status` |
| `gl` | Últimos 20 commits en gráfico |
| `Ctrl+Shift+,` | Recargar config de Ghostty |
| `Super+1..4` / `Super+Shift+1..4` | Ir a / mover ventana al escritorio 1..4 |
| `Shift+Espacio` | Ulauncher |
| `Super+T` | Tactile (cuadrícula de ventanas) |
| `Super+flechas` | Tiling Assistant |
| `traducir`, `tr4` | Traducir el portapapeles (modelo 12b / 4b) |
| `instalar`, `desinstalar` | Instalar/quitar `.deb` o `.AppImage` |
| `Ctrl+P` / `Ctrl+B` (en nvim) | Abrir archivo / explorador |
| `ollama run glm-ocr "Text Recognition: ./img.png"` | Leer el texto de una imagen (OCR local) |
| `v` / `h` | Neovim / herdr (`Ctrl+a` es el prefijo; ver [docs/08](docs/08-neovim.md)) |

## 📖 Cómo usar las utilidades

> Guía completa por categorías, con ejemplos: **[docs/](docs/README.md)**.

### Navegar y buscar
| Herramienta | Ejemplo |
|---|---|
| **zoxide** | `z dotfiles` salta a una carpeta que ya visitaste; `zi` elige de una lista |
| **fzf** | `Ctrl+R` historial, `Ctrl+T` archivos, `Alt+C` carpetas |
| **ripgrep** | `rg "texto"` busca en todos los archivos de la carpeta |
| **fd** | `fd nombre` busca archivos por nombre (alias de `fdfind`) |
| **arbol / explorar** | `arbol` muestra el árbol de carpetas; `explorar` busca archivos y previsualiza (Markdown con formato, código con colores) |
| **eza / bat** | `ls`, `ll`, `tree` y `cat` ya usan estas herramientas por alias |

### Git
| Herramienta | Ejemplo |
|---|---|
| **lazygit** | `lazygit` interfaz completa de git; `?` muestra la ayuda de teclas |
| **delta** | Automático: `git diff` y `git log -p` se ven lado a lado |
| **meld** | `meld carpetaA carpetaB` compara; `git mergetool` lo usa para conflictos |
| **gh** | `gh repo clone usuario/repo`, `gh pr create` |

#### Ejemplo de `~/.gitconfig`

Mi `.gitconfig` es personal y no está en el repo. Este es un ejemplo con delta, para copiar y cambiar tus datos:

```ini
[user]
	name = Tu Nombre
	email = tu@correo.com
[core]
	pager = delta
[interactive]
	diffFilter = delta --color-only
[delta]
	navigate = true
	line-numbers = true
	side-by-side = true
[merge]
	conflictStyle = zdiff3
	tool = meld
[mergetool]
	prompt = false
```

Para que `git push` use tu cuenta de GitHub: `gh auth login`.

### Datos y APIs
| Herramienta | Ejemplo |
|---|---|
| **jq / yq** | `curl -s url \| jq '.items[0]'`, `yq '.clave' archivo.yml` |
| **xh** | `xh GET api.com/users`, `xh POST api.com/users name=ana` |
| **hurl** | Guarda la petición en `x.hurl` (`GET https://api.com/users` y `HTTP 200`) y corre `hurl x.hurl` |
| **posting** | `posting` cliente de APIs en terminal con colecciones guardadas |
| **bruno** | Cliente gráfico desde el menú de aplicaciones |
| **dbeaver** | Cliente gráfico de bases de datos, desde el menú |

### Proyectos
| Herramienta | Ejemplo |
|---|---|
| **direnv** | En un proyecto con `.envrc` ejecuta `direnv allow` una vez; luego carga el entorno solo. Con Nix, el `.envrc` lleva `use flake` |
| **lazydocker** | `lazydocker` interfaz de terminal para ver y manejar contenedores Docker (como lazygit, pero para Docker) |
| **just** | Define tareas en un `justfile` y corre `just` (lista) o `just nombre` |
| **mise** | `mise use node@22` fija versiones de lenguajes por proyecto |

### Sistema y ayuda
| Herramienta | Ejemplo |
|---|---|
| **btop** | `btop` monitor de CPU, memoria y procesos |
| **dust / duf** | `dust` qué ocupa espacio en la carpeta; `duf` uso de discos |
| **hyperfine** | `hyperfine 'comando'` mide cuánto tarda |
| **glow** | `glow README.md` lee Markdown con formato |
| **tldr** | `tldr tar` ejemplos cortos de un comando |
| **CopyQ** | Historial del portapapeles (abre desde el menú) |

### Comandos propios
| Comando | Qué hace |
|---|---|
| `traducir` | Traduce al español lo que tengas copiado (modelo 12b, mejor calidad). `traducir English` traduce a otro idioma |
| `tr4` | Igual pero con el modelo 4b, más rápido para frases cortas |
| `cat archivo \| traducir` | Traduce el contenido de un archivo en vez del portapapeles |
| `instalar` | Instala el último `.deb` o `.AppImage` de Descargas (o el que indiques: `instalar archivo.deb`). Los AppImage van a `~/Aplicaciones` |
| `desinstalar nombre` | Quita un paquete apt; si el nombre no es exacto, muestra coincidencias |

## 🚀 Instalación en una PC nueva

Pensado para Ubuntu (funciona en otras distros con Nix). **No ejecutes `install.sh` con `sudo`**:
se instala en tu usuario y pide sudo solo cuando hace falta.

### 1. Clonar

```bash
git clone https://github.com/<tu-usuario>/dotfiles.git ~/dotfiles
```

(Si el repo es privado: `gh auth login` y luego `gh repo clone <tu-usuario>/dotfiles ~/dotfiles`.)

### 2. Elegir qué instalar

```bash
~/dotfiles/install.sh                 # pregunta grupo por grupo
```

```bash
~/dotfiles/install.sh terminal dev    # solo esos grupos (base siempre va)
```

```bash
~/dotfiles/install.sh todo            # todos los grupos
```

Grupos: `terminal`, `dev`, `ia`, `documentos`, `multimedia` y `escritorio` (ver la tabla de arriba).
Se puede volver a ejecutar cuando quieras: lo que ya está instalado se salta.

### 3. Con root o sin root

`install.sh` lo detecta solo (si tu usuario está en el grupo `sudo`), o lo eliges con `--con-root` / `--sin-root`.

| | Con root | Sin root |
|---|---|---|
| Nix | Si falta, pregunta e instala el oficial de [nixos.org](https://nixos.org/download) (sudo una vez, para crear `/nix`) | Se usa si ya está instalado. Si no, solo se copian las configs y te avisa |
| apt | Lo mínimo: `curl`, `git`, `wget`, `unzip`, `bash-completion`, `flatpak`, `libfuse2t64` (`packages/apt.txt`) | Nada |
| Programas | Nix, en tu usuario | Igual |
| Apps gráficas | Flatpak con `--user` | Igual, si `flatpak` ya está instalado |

Lo que **nunca** hace: añadir PPAs o repos apt de terceros, instalar `.deb` con sudo ni añadir remotos
Flatpak al sistema. Los únicos `curl | sh` son Claude Code, agy y OpenCode 1, y solo si dices que sí.

Al terminar muestra un resumen con los avisos (lo que faltó o falló). Luego abre una terminal nueva;
si las apps de Nix o Flatpak no salen en el menú, cierra sesión y vuelve a entrar.

> **Sin root y sin Nix** quedan las configs y Bash con colores, pero sin starship, ble.sh ni las
> herramientas. Pide a un admin que instale Nix una vez y vuelve a ejecutar `install.sh`.

> **Elgato (opcional):** en el grupo `escritorio` pregunta si tienes Stream Deck o micrófono Wave. Si no,
> responde `N`. Detalles en [docs/10-elgato.md](docs/10-elgato.md).

### Agregar un programa

1. Instálalo: `nix profile add nixpkgs#nombre` (atajo `nixi nombre`).
2. Anótalo en el grupo que toque: `packages/nix/<grupo>.txt`.

`backup.sh` te avisa si hay paquetes Nix instalados que no están en ningún grupo.

## 🔄 Guardar cambios

Después de modificar la configuración:

```bash
~/dotfiles/backup.sh
```

## 🎨 Personalización

- **Transparencia:** `background-opacity` en `ghostty/config` (1.0 = sólido)
- **Color del primer segmento del prompt:** `azul = "#1e66f5"` en `starship.toml`
- **Ver temas de Ghostty:** `ghostty +list-themes`

Tactile y Auto Move Windows se instalan desde el Gestor de extensiones (no están en apt); `gnome/extensions.txt` lista las activas.

## ⚠️ Problemas conocidos

- **Flatpak/Nix:** las apps no aparecen en el menú hasta cerrar sesión (`XDG_DATA_DIRS`).
- **Ulauncher en Wayland:** su propio atajo no funciona; se usa un atajo de GNOME que ejecuta `ulauncher-toggle`.
- **AppImage que no abre:** instalar `libfuse2t64`.
- **Shift+Espacio** deja de escribir espacio en todas las apps.
- **venv con el Python de Nix:** las librerías compiladas (numpy, onnxruntime...) fallan con
  `libstdc++.so.6: cannot open shared object file`. Se arregla con
  `export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu` al ejecutar.
- **Ollama:** el grupo `ia` pregunta modelo por modelo (en total pesan ~22 GB); la lista con tamaños está en `packages/ollama.txt`.
- **markitdown:** no instalarlo con `nix profile add nixpkgs#markitdown` (falla con PDF y Word). Usa `nix profile add --impure -I nixpkgs=flake:nixpkgs --file packages/markitdown.nix`; `install.sh` ya lo hace. Con tablas en PDF sale peor que `pdftotext -layout`.
- **docling:** la primera vez descarga ~0,5 GB de modelos a `~/.cache/huggingface`. En mi prueba (un PDF sencillo generado con LibreOffice) no detectó las tablas; úsalo solo con PDFs complejos y compáralo con `pdftotext -layout`.
