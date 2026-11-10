# 8. Neovim y herdr

## Neovim (LazyVim)
Editor en la terminal con LSP, buscador, explorador y git ya configurados. Se abre con `v` (alias de `nvim`).
La primera vez descarga los plugins solo; los servidores de lenguajes (TypeScript, Python, Bash, YAML, Docker, Markdown) los instala **Mason**. Nix (`nil`, `nixfmt`) viene de `packages/nix.txt`.

| Atajo | Acción |
|---|---|
| `Espacio` | Menú de atajos (espera y muestra opciones) |
| `Espacio Espacio` | Buscar archivo |
| `Espacio /` | Buscar texto en el proyecto (ripgrep) |
| `Espacio e` | Explorador de archivos |
| `Espacio g g` | lazygit dentro de Neovim |
| `gd` / `K` / `Espacio c a` | Ir a definición / documentación / acciones de código |
| `Espacio c f` | Formatear |
| `Ctrl+h/j/k/l` | Moverse entre divisiones |
| `Espacio q q` | Salir |

Comandos útiles: `:LazyExtras` (activar lenguajes), `:Mason` (servidores), `:Lazy` (plugins), `:checkhealth`.
Config en `nvim/` del repo (`lua/plugins/` para añadir plugins). Tema: Catppuccin Mocha con fondo transparente.

## herdr (paneles, sesiones y agentes)
Multiplexor tipo tmux que además muestra el estado de agentes como Claude Code. Se abre con `h`.
Las sesiones siguen vivas aunque cierres la terminal. Prefijo: `Ctrl+a`.

| Atajo | Acción |
|---|---|
| `Ctrl+a v` | Dividir a la derecha |
| `Ctrl+a -` | Dividir abajo |
| `Ctrl+a h/j/k/l` | Moverse entre paneles |
| `Ctrl+a c` / `n` / `p` | Nueva pestaña / siguiente / anterior |
| `Ctrl+a z` | Zoom del panel |
| `Ctrl+a x` | Cerrar panel |
| `Ctrl+a q` | Desconectar (la sesión sigue) |
| `Ctrl+a Alt+g` | lazygit flotante |
| `Ctrl+a ?` | Ayuda con todos los atajos |

Config: `herdr/config.toml`. Recargar: `herdr server reload-config`. Actualizar: `herdr update`.
> Dentro de Neovim, `Ctrl+h/j/k/l` mueve entre divisiones de nvim; entre paneles de herdr usa `Ctrl+a h/j/k/l`.
