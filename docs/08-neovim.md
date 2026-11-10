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
| `Espacio q q` | Salir de Neovim por completo |
| `:q` / `:qa` / `:qa!` | Cerrar ventana / salir de todo / salir sin guardar |
| `Esc` | Cerrar buscador o recuadro |
| `:w` | Guardar |

Comandos útiles: `:LazyExtras` (activar lenguajes), `:Mason` (servidores), `:Lazy` (plugins), `:checkhealth`.
Config en `nvim/` del repo (`lua/plugins/` para añadir plugins). Tema: Catppuccin Mocha con fondo transparente.

### Vista previa (Markdown e imágenes)
| Qué | Cómo |
|---|---|
| Markdown con formato dentro de Neovim | Se ve solo (render-markdown); `Espacio u m` activa/desactiva |
| Markdown en el navegador | `Espacio c p` abre la vista previa en vivo |
| Imágenes (png, jpg, gif, pdf) | Abre el archivo con `v foto.png`: se dibuja en la terminal (Ghostty). Las del Markdown `![](img.png)` también |
| Ver imágenes y archivos al buscar | `Espacio Espacio` y navega: el panel derecho es la vista previa |

Las imágenes necesitan `imagemagick` y `gs` (en `packages/nix.txt`). Dentro de herdr pueden no dibujarse; si pasa, ábrelas en una ventana de Ghostty fuera de herdr.

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
| `Ctrl+a q` | Desconectar (la sesión sigue viva) |
| `Ctrl+a Alt+g` | lazygit flotante |
| `Ctrl+a ?` | Ayuda con todos los atajos |

Para cerrar herdr del todo (servidor y sesiones): `herdr server stop`.
Config: `herdr/config.toml`. Recargar: `herdr server reload-config`. Actualizar: `herdr update`.
> Dentro de Neovim, `Ctrl+h/j/k/l` mueve entre divisiones de nvim; entre paneles de herdr usa `Ctrl+a h/j/k/l`.

## Casos prácticos

### Empezar el día
```bash
h                 # abre (o vuelve a) tu sesión de herdr
v .               # en el panel: Neovim con el explorador de la carpeta
```
`Ctrl+a v` divide a la derecha: ahí abres `claude` u otro agente; la barra lateral muestra si trabaja, espera o terminó.

### Editar un archivo y probarlo
1. `Espacio Espacio` → escribe parte del nombre → `Enter`.
2. Edita y guarda con `:w` (formatea solo al guardar).
3. `Ctrl+a j` baja al panel de terminal y ejecuta el comando (`npm test`, `just dev`...).
4. `Ctrl+a k` vuelve al editor.

### Buscar dónde se usa algo
- `Espacio /` y escribe el texto: busca en todo el proyecto, con vista previa.
- Sobre una función: `gd` va a su definición, `gr` lista dónde se usa, `K` muestra su documentación.

### Renombrar una variable en todo el proyecto
Cursor sobre el nombre → `Espacio c r` → escribe el nuevo → `Enter`.

### Commit sin salir de Neovim
`Espacio g g` abre lazygit; `q` lo cierra. En herdr también: `Ctrl+a Alt+g` lo abre flotante.

### Avisos molestos del linter de Markdown
Las reglas desactivadas están en `.markdownlint-cli2.yaml` (se copia a `~/`). Para ignorar una más, añade `MDxxx: false` ahí.

### Cerrar al terminar
- Solo Neovim: `Espacio q q`.
- Dejar todo vivo para mañana: `Ctrl+a q` (después, `h` vuelve a donde estabas).
- Apagar todo: `herdr server stop`.

### Si algo falla
`:checkhealth` (diagnóstico), `:LspInfo` (servidor del archivo), `:Mason` (instalar servidores), `:Lazy` (plugins).
