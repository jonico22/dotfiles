-- Diffs y historial de git en pantalla completa
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff de cambios (Diffview)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Historial del archivo" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Historial del repo" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Cerrar Diffview" },
    },
    opts = {},
  },
}
