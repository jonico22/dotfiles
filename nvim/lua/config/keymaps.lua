-- Atajos tipo VS Code (se suman a los de LazyVim)
-- Ya incluidos en LazyVim: Ctrl+S guardar, Alt+j/k mover línea, gcc comentar, Ctrl+/ terminal
local map = vim.keymap.set

map("n", "<C-p>", function() Snacks.picker.files() end, { desc = "Abrir archivo (Ctrl+P)" })
map("n", "<C-b>", function() Snacks.explorer() end, { desc = "Explorador (Ctrl+B)" })
map("n", "<leader>o", "<cmd>AerialToggle!<cr>", { desc = "Esquema de símbolos" })
