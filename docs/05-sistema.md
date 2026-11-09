# 5. Sistema y ayuda

## btop
Monitor de CPU, memoria, disco y procesos. `q` sale.
```bash
btop
```

## dust y duf
```bash
dust            # qué ocupa espacio en esta carpeta
dust -d 2       # solo 2 niveles de profundidad
duf             # uso de cada disco, en una tabla
```

## hyperfine
Mide cuánto tarda un comando, o compara dos.
```bash
hyperfine 'ls'
hyperfine 'grep -r texto .' 'rg texto'    # compara cuál es más rápido
```

## glow
Lee Markdown con formato en la terminal.
```bash
glow README.md
glow -p README.md     # con paginación (flechas, q para salir)
md README.md          # atajo propio: glow con estilo propio, sin los # de los títulos
```

## tldr
Ejemplos cortos y prácticos de un comando, mejor que el manual.
```bash
tldr tar
tldr --update        # actualizar la base de ejemplos
```

## Otros
| Programa | Para qué |
|---|---|
| **CopyQ** | Historial del portapapeles (se abre desde el menú) |
| **Dialect** | Traductor gráfico |
