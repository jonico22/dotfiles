-- nil y nixfmt vienen de Nix (packages/nix/dev.txt), no de Mason.
-- En macOS no existe nil en Homebrew: solo se activan si están instalados.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = { mason = false, enabled = vim.fn.executable("nil") == 1 },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = vim.fn.executable("nixfmt") == 1 and { "nixfmt" } or nil,
      },
    },
  },
}
