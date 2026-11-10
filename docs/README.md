# 📚 Guía de comandos

Guías cortas para usar las herramientas de este repo desde la terminal.
Cada una dice **qué hace** y trae los **ejemplos que más se usan**.

| Guía | Qué encontrarás |
|---|---|
| [1. Navegar y buscar](01-navegar-y-buscar.md) | `z`, `fzf`, `rg`, `fd`, `arbol`, `explorar`, `eza`, `bat` |
| [2. Git y GitHub](02-git.md) | `lazygit`, `delta`, `gh`, `meld` |
| [3. APIs y datos](03-apis-y-datos.md) | `xh`, `hurl`, `posting`, `jq`, `yq`, Bruno, DBeaver |
| [4. Proyectos](04-proyectos.md) | `direnv`, `just`, `mise`, `lazydocker` |
| [5. Sistema](05-sistema.md) | `btop`, `dust`, `duf`, `hyperfine`, `glow`, `tldr` |
| [6. Comandos propios y atajos](06-propios-y-atajos.md) | `traducir`, `tr4`, `instalar`, `desinstalar`, atajos |
| [7. Instalar programas](07-instalar-programas.md) | `nix`, `flatpak`, `apt` y los scripts del repo |
| [8. Neovim y herdr](08-neovim.md) | `nvim` (LazyVim), `herdr`, atajos |

## Resumen rápido

| Quiero... | Uso |
|---|---|
| Ir a una carpeta que ya visité | `z nombre` |
| Buscar en el historial | `Ctrl+R` |
| Buscar texto en archivos | `rg "texto"` |
| Buscar un archivo por nombre | `fd nombre` |
| Ver el árbol y previsualizar archivos | `arbol` / `explorar` |
| Manejar git sin memorizar comandos | `lazygit` |
| Probar una API | `xh GET url` |
| Guardar endpoints | `posting` o `hurl` |
| Ver qué ocupa espacio | `dust` |
| Ver ejemplos de un comando | `tldr comando` |
| Traducir lo que copié | `traducir` |
| Instalar un .deb descargado | `instalar` |
| Editar código en la terminal | `v` (Neovim) |
| Dividir la terminal / agentes | `h` (herdr) |

> Si no recuerdas cómo se usa algo: `tldr <comando>` o `<comando> --help`.
