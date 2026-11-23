# 7. Instalar programas y usar este repo

## Dónde instalar cada cosa
| Tipo | Cómo |
|---|---|
| Herramientas de terminal y apps | **Nix**: `nix profile add nixpkgs#nombre` (en tu usuario, sin sudo) |
| Apps con interfaz | **Flatpak** con `--user`, o `.deb` con `instalar` (pide sudo) |
| Base del sistema | `sudo apt install nombre` (solo si tienes root) |

## Nix
```bash
nix search nixpkgs nombre          # buscar un paquete      (atajo: nixs nombre)
nix profile add nixpkgs#nombre     # instalar              (atajo: nixi nombre)
nix profile list                   # ver lo instalado      (atajo: nixl)
nix profile remove nombre          # quitar                 (atajo: nixr nombre)
```

## Homebrew (macOS)
```bash
brew search nombre            # buscar
brew install nombre           # instalar una fórmula (usa --cask para apps)
brew bundle --file=mac/Brewfile.dev   # instalar un grupo
```
Después de instalar, anótalo en su `mac/Brewfile.<grupo>` (`backup.sh` avisa si falta alguno).

## Flatpak
```bash
flatpak install --user flathub app.drey.Dialect
flatpak list --app
flatpak uninstall app.drey.Dialect
```

## Respaldar y restaurar este repo
```bash
~/dotfiles/backup.sh    # copia tu config al repo, hace commit y push
~/dotfiles/install.sh   # en una PC nueva: elige grupos y copia la config
~/dotfiles/install.sh terminal dev   # solo esos grupos
```
Para guardar un archivo nuevo en el respaldo, agrégalo en `files.sh`.
Después de instalar con Nix, anota el paquete en su grupo: `packages/nix/<grupo>.txt` (`backup.sh` avisa si falta alguno).
