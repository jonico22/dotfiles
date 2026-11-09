# 7. Instalar programas y usar este repo

## Dónde instalar cada cosa
| Tipo | Cómo |
|---|---|
| Herramientas de terminal y apps | **Nix**: `nix profile add nixpkgs#nombre` |
| Apps con interfaz | **Flatpak** o `.deb` con `instalar` |
| Base del sistema | `sudo apt install nombre` |

## Nix
```bash
nix search nixpkgs nombre          # buscar un paquete
nix profile add nixpkgs#nombre     # instalar
nix profile list                   # ver lo instalado
nix profile remove nombre          # quitar
```

## Flatpak
```bash
flatpak install flathub app.drey.Dialect
flatpak list --app
flatpak uninstall app.drey.Dialect
```

## Respaldar y restaurar este repo
```bash
~/dotfiles/backup.sh    # copia tu config al repo, hace commit y push
~/dotfiles/install.sh   # en una PC nueva: instala todo y copia la config
```
Para guardar un archivo nuevo en el respaldo, agrégalo en `files.sh`.
Después de instalar con Nix, anota el paquete en `packages/nix.txt` (o ejecuta `backup.sh`, que lo regenera).
