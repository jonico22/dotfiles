# 4. Proyectos

## direnv + nix-direnv
Al entrar a una carpeta de proyecto carga solo su entorno y variables, y al salir los descarga.
```bash
cd mi-proyecto
echo 'use flake' > .envrc     # si el proyecto tiene flake.nix (o: use nix)
direnv allow                  # autorizar el .envrc, una sola vez
```
Para cargar variables de un `.env`, el `.envrc` puede llevar `dotenv`.
Si cambias el `.envrc`, vuelve a ejecutar `direnv allow`.

## just
Guarda los comandos del proyecto en un archivo `justfile`, para no recordarlos.
```make
# justfile
dev:
    npm run dev

test:
    npm test
```
```bash
just          # lista las tareas
just dev      # ejecuta "dev"
```

## mise
Fija la versión de lenguajes por proyecto (Node, Python, etc.).
```bash
mise use node@22     # usa Node 22 en esta carpeta
mise ls              # ver lo instalado
```

## lazydocker
Como lazygit, pero para contenedores: ver, reiniciar y leer logs.
```bash
lazydocker
```
> Necesita un motor de contenedores en marcha (Docker, o Podman con su socket activado).
