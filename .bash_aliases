# Alias cortos (se carga desde .bashrc)

# Nix
if command -v nix >/dev/null; then
  nixi() { nix profile add "nixpkgs#$1"; } # nixi paquete  -> instalar
  alias nixs='nix search nixpkgs'          # nixs texto    -> buscar
  alias nixl='nix profile list'            # ver lo instalado
  alias nixr='nix profile remove'          # nixr paquete  -> quitar
fi

# Git
alias lg='lazygit'

# apt (Linux) / Homebrew (macOS)
if command -v apt >/dev/null; then
  alias agi='sudo apt install -y'          # agi paquete
  alias agu='sudo apt update && sudo apt upgrade -y'
fi
if [ "$(uname)" = Darwin ]; then
  alias bi='brew install'                  # bi paquete
  alias bs='brew search'                   # bs texto
  alias bu='brew update && brew upgrade'
fi

# direnv
alias da='direnv allow'

# Editor y multiplexor
alias v='nvim'
alias h='herdr'
