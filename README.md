# 🖥️ Dotfiles — Terminal Ghostty + Bash

Mi configuración de terminal para desarrollo en Ubuntu.

## 📦 Qué incluye

| Archivo | Ubicación real | Descripción |
|---|---|---|
| `.bashrc` | `~/.bashrc` | Configuración de Bash, alias e integraciones |
| `ghostty/config` | `~/.config/ghostty/config` | Tema, fuente y transparencia de Ghostty |
| `starship/starship.toml` | `~/.config/starship.toml` | Prompt con colores (Catppuccin Powerline) |

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
