# 2. Git y GitHub

## lazygit
Interfaz de git en la terminal. Con ella casi no necesitas memorizar comandos.
```bash
lazygit     # ejecútalo dentro de un repositorio (atajo: lg)
```
| Tecla | Hace |
|---|---|
| `?` | Ayuda de la pantalla actual |
| `Tab` / flechas | Cambiar de panel / moverse |
| `Espacio` | Agregar o quitar un archivo del commit (stage) |
| `c` | Hacer commit |
| `P` (mayúscula) | Push |
| `p` (minúscula) | Pull |
| `q` | Salir |

## delta
Hace que `git diff`, `git show` y `git log -p` se vean con colores y lado a lado.
No se ejecuta solo: funciona al usar git. Dentro del diff, `n` y `N` saltan al archivo siguiente o anterior.
La configuración está en el ejemplo de `.gitconfig` del [README](../README.md).

## gh (GitHub CLI)
```bash
gh auth login                 # conectar tu cuenta (una sola vez)
gh repo clone usuario/repo    # clonar
gh repo create                # crear un repo nuevo
gh pr create                  # abrir un pull request de la rama actual
gh pr list                    # ver pull requests abiertos
gh issue list                 # ver issues
```

## meld
Compara archivos o carpetas lado a lado, con interfaz gráfica.
```bash
meld a.txt b.txt
meld carpetaA carpetaB
git mergetool            # resolver conflictos de merge con meld
```

## Alias de git que ya tienes
| Alias | Hace |
|---|---|
| `gs` | `git status` |
| `gl` | Últimos 20 commits en gráfico |
