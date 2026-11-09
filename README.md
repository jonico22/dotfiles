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
| `glow/estilo.json` | `~/.config/glow/estilo.json` | Estilo de glow para Markdown (sin los `#` en los títulos) |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` | delta como pager |
| `ulauncher/*.json` | `~/.config/ulauncher/` | Preferencias, atajos web y extensiones |
| `direnv/direnvrc` | `~/.config/direnv/direnvrc` | Activa nix-direnv |
| `gnome/*.ini` | dconf | Escritorios, atajos y extensiones de GNOME |
| `packages/*.txt` | — | Listas apt, Nix, Flatpak y modelos Ollama |
| `files.sh` | — | Lista única de archivos usada por `backup.sh` e `install.sh` |

## 🛠️ Programas instalados

| Programa | Para qué sirve |
|---|---|
| [Ghostty](https://ghostty.org) | Terminal rápida con GPU |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com) | Fuente con íconos para el prompt |
| [Starship](https://starship.rs) | Prompt con rama de git, versión de Node, hora, etc. |
| [ble.sh](https://github.com/akinomyoga/ble.sh) | Autosugerencias y resaltado de sintaxis en Bash |
| [fzf](https://github.com/junegunn/fzf) | Búsqueda difusa en historial y archivos |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` inteligente que recuerda tus carpetas |
| [eza](https://github.com/eza-community/eza) | `ls` con colores, íconos y estado de git |
| [bat](https://github.com/sharkdp/bat) | `cat` con resaltado de sintaxis |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Búsqueda rápida de texto (`rg`) |
| [fd](https://github.com/sharkdp/fd) | Búsqueda rápida de archivos |

| [Ulauncher](https://ulauncher.io) | Lanzador de apps (Shift+Espacio) |
| [Ollama](https://ollama.com) | Modelos locales (translategemma) para traducir |
| [delta](https://github.com/dandavison/delta) | Diffs de git con colores y lado a lado |
| [direnv](https://direnv.net) | Carga el entorno de cada proyecto (`.envrc`) |
| [Zed](https://zed.dev) | Editor de código rápido (instalador oficial, en `~/.local/zed.app`) |
| [Bruno](https://www.usebruno.com) | Cliente de APIs gráfico (.deb oficial; la versión de Nix falla por el sandbox) |
| CopyQ, btop, tealdeer (`tldr`), Dialect (Flatpak) | Portapapeles, monitor, ayuda rápida, traductor gráfico |

### Paquetes Nix (`packages/nix.txt`)

| Paquete | Para qué |
|---|---|
| gh, git, lazygit | GitHub CLI, git, interfaz git en terminal |
| nodejs, pnpm, python3 | Lenguajes y gestor de paquetes |
| podman | Contenedores |
| mpv, yt-dlp | Reproductor y descargador de video |
| lapce | Editor de código |
| nixGL | Ejecutar apps gráficas de Nix (se instala aparte: `github:nix-community/nixGL`) |

Herramientas CLI y apps instaladas con Nix (ver `packages/nix.txt`):

| Paquete | Para qué |
|---|---|
| direnv + nix-direnv | Al entrar a una carpeta de proyecto carga solo sus variables `.env` y su entorno de Nix, y al salir los descarga. Con Nix es lo más útil de todo |
| jq / yq-go | Leer y filtrar JSON y YAML (`cat package.json \| jq .scripts`) |
| xh | Probar APIs desde la terminal, más simple que curl (`xh POST :3000/api name=jose`) |
| posting | Cliente de APIs en la terminal, tipo Postman (`posting`) |
| hurl | Guardar endpoints en archivos `.hurl` y ejecutarlos (`hurl archivo.hurl`) |
| just | Guardar los comandos del proyecto en un `justfile` (`just dev`, `just test`) |
| glow | Leer Markdown con formato en la terminal (`glow CLAUDE.md`) |
| lazydocker | Lo mismo que lazygit, pero para contenedores Docker |
| hyperfine | Medir y comparar la velocidad de comandos |
| dust, duf | Ver qué ocupa espacio en disco, de forma visual |
| dbeaver-bin | Cliente gráfico de bases de datos |
| meld | Comparar archivos y carpetas |

Si alguna app gráfica de Nix abre con errores de OpenGL, ejecútala con `nixGL <app>`.

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

> Requisito: tener Ghostty instalado.

```bash
gh repo clone dotfiles ~/dotfiles
~/dotfiles/install.sh
```

Luego cierra y abre Ghostty.

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
