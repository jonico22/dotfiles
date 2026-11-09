# 1. Navegar y buscar

## zoxide (`z`)
Es un `cd` que aprende. Recuerda las carpetas que visitas y te lleva con pocas letras.
```bash
z dotfiles      # salta a la carpeta que más coincida con "dotfiles"
z api src       # varias palabras: busca una ruta que las contenga
zi              # elige de una lista interactiva
```
> Primero tienes que haber entrado antes a la carpeta con `cd`.

## fzf (búsqueda difusa)
Atajos que ya funcionan en la terminal:
| Atajo | Hace |
|---|---|
| `Ctrl+R` | Busca en el historial de comandos |
| `Ctrl+T` | Busca un archivo y pega su ruta |
| `Alt+C` | Entra a una carpeta buscándola |
```bash
nano $(fzf)             # elige un archivo y ábrelo
git log --oneline | fzf # filtra una lista que viene de otro comando
```

## ripgrep (`rg`)
Busca texto dentro de los archivos, muy rápido. Ignora `.git` y lo de `.gitignore`.
```bash
rg "TODO"            # todas las líneas con TODO
rg -i "error"        # sin distinguir mayúsculas
rg -l "usuario"      # solo los nombres de archivo
rg "función" -t md   # solo en archivos Markdown
```

## fd
Busca archivos y carpetas por nombre. (En Ubuntu el programa se llama `fdfind`; ya hay alias `fd`.)
```bash
fd config            # nombres que contengan "config"
fd -e md             # todos los .md
fd -t d src          # solo carpetas llamadas "src"
```

## arbol y explorar (comandos propios)
Ver carpetas y previsualizar archivos sin salir de la terminal.
```bash
arbol              # árbol de la carpeta actual (2 niveles)
arbol src 3        # árbol de "src" con 3 niveles
explorar           # lista de archivos con vista previa a la derecha
explorar docs      # lo mismo, dentro de la carpeta "docs"
```
En `explorar`: escribe para filtrar, flechas para moverte, `Enter` abre el archivo completo (los `.md` con formato; `q` vuelve a la lista) y `Esc` sale.
La vista previa muestra los `.md` con formato (glow), el código con colores (bat) y las carpetas como árbol.

Para leer un Markdown completo: `md archivo.md` (`q` sale).

## eza y bat (ya van por alias)
| Alias | Equivale a |
|---|---|
| `ls` | `eza --icons` (con íconos, carpetas primero) |
| `ll` | `eza -la --git` (detalles y estado de git) |
| `tree` | Árbol de carpetas. Limita la profundidad: `eza --tree -L 2` |
| `cat archivo` | `batcat` (con colores y números de línea) |
