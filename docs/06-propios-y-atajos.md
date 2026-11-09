# 6. Comandos propios y atajos

## Comandos propios
Definidos en `.bash_traductor` y `.bash_instalar`.

### traducir y tr4
Traducen con IA local (Ollama). Requieren los modelos descargados (`ollama list`).
```bash
traducir                   # traduce al español lo que tengas copiado
traducir English           # traduce a otro idioma
cat archivo.txt | traducir # traduce el contenido de un archivo
tr4                        # igual, pero más rápido (modelo pequeño)
```
| Comando | Cuándo |
|---|---|
| `traducir` | Textos largos (mejor calidad, más lento) |
| `tr4` | Frases cortas (más rápido) |

### arbol y explorar
Ver [Navegar y buscar](01-navegar-y-buscar.md#arbol-y-explorar-comandos-propios).

### md
`md archivo.md` lee un Markdown con formato (atajo de `glow` con estilo propio). `q` sale.

### instalar y desinstalar
```bash
instalar                  # instala el último .deb o .AppImage de Descargas (pide confirmación)
instalar archivo.deb      # instala uno concreto
desinstalar nombre        # quita un paquete; si no es exacto, muestra coincidencias
```
Los `.AppImage` se copian a `~/Aplicaciones`. Si uno no abre, instala `libfuse2t64`.

## Atajos
| Atajo | Hace |
|---|---|
| `→` | Aceptar la autosugerencia (ble.sh) |
| `Ctrl+R` / `Ctrl+T` / `Alt+C` | fzf: historial / archivos / carpetas |
| `Super+1..4` | Ir al escritorio 1 a 4 |
| `Super+Shift+1..4` | Mover la ventana al escritorio 1 a 4 |
| `Shift+Espacio` | Ulauncher (lanzador). Ej.: `g texto` busca en Google, `so` Stack Overflow, `wiki` Wikipedia |
| `Super+T` | Tactile (cuadrícula de ventanas) |
| `Super+flechas` | Tiling Assistant (ajustar ventana a la mitad o maximizar) |
| `Ctrl+Shift+,` | Recargar la config de Ghostty |
