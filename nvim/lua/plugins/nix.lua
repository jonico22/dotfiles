-- nil y nixfmt vienen de Nix (packages/nix.txt), no de Mason
return {
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { nil_ls = { mason = false } } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { nix = { "nixfmt" } } },
  },
}
