# 3. APIs y datos

## xh (peticiones rápidas)
Como `curl`, pero más simple. No guarda nada: es para probar.
```bash
xh GET api.com/users                         # GET
xh POST api.com/users nombre=ana edad:=30    # POST con JSON (:= para números y booleanos)
xh :3000/api/items                           # :3000 equivale a localhost:3000
xh api.com/me Authorization:"Bearer TOKEN"   # con cabecera
xh -d api.com/archivo.zip                    # descargar
```

## hurl (endpoints guardados en archivos)
Escribes la petición en un archivo de texto y la ejecutas. Se guarda en git junto al proyecto.
```
# usuarios.hurl
GET https://api.com/users
HTTP 200
[Asserts]
jsonpath "$[0].nombre" == "Ana"
```
```bash
hurl usuarios.hurl            # ejecutar
hurl --test usuarios.hurl     # ejecutar y mostrar si pasan las comprobaciones
```

## posting (estilo Postman, en la terminal)
```bash
posting
```
Guardas peticiones en colecciones y variables. La barra de abajo muestra los atajos de cada pantalla (por ejemplo `Ctrl+J` para enviar y `Ctrl+P` para la paleta de comandos).

## jq (JSON)
```bash
cat package.json | jq .scripts                  # una clave
curl -s api.com/users | jq '.[0]'               # el primer elemento
curl -s api.com/users | jq -r '.[].nombre'      # solo los nombres, sin comillas
jq . archivo.json                               # formatear con colores
```

## yq (YAML)
```bash
yq '.services' docker-compose.yml               # leer
yq -i '.version = "2"' archivo.yml              # modificar el archivo (-i)
```

## Programas con interfaz gráfica
| Programa | Para qué |
|---|---|
| **Bruno** | Cliente de APIs con colecciones guardadas (menú de aplicaciones) |
| **DBeaver** | Conectarte y consultar bases de datos (menú de aplicaciones) |

## ¿Cuál uso?
| Necesito... | Uso |
|---|---|
| Probar algo ahora | `xh` |
| Guardar peticiones y verlas en pantalla | `posting` o Bruno |
| Guardarlas como texto en el proyecto | `hurl` |
