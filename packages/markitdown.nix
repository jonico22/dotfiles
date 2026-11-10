# markitdown de nixpkgs pero con soporte de PDF, Word, PowerPoint y Excel
# (el paquete normal viene sin esos extras y falla al convertirlos).
# Instalar: nix profile add --impure --file packages/markitdown.nix
let
  pkgs = import <nixpkgs> { };
  py = pkgs.python3Packages;
in
py.toPythonApplication (py.markitdown.overridePythonAttrs (o: {
  dependencies = o.dependencies
    ++ (with py.markitdown.optional-dependencies; pdf ++ docx ++ pptx ++ xlsx);
  doCheck = false;
}))
