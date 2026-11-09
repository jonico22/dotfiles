# Alias cortos (se carga desde .bashrc)

# Nix
nixi() { nix profile add "nixpkgs#$1"; }   # nixi paquete  -> instalar
alias nixs='nix search nixpkgs'            # nixs texto    -> buscar
alias nixl='nix profile list'              # ver lo instalado
alias nixr='nix profile remove'            # nixr paquete  -> quitar

# Git
alias lg='lazygit'

# apt
alias agi='sudo apt install -y'            # agi paquete
alias agu='sudo apt update && sudo apt upgrade -y'

# direnv
alias da='direnv allow'
