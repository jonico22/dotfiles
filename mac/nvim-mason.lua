-- Carga Mason y espera a que terminen todas las instalaciones (LSP, formateadores...)
-- antes de salir, para que nvim --headless no las aborte.
local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.cmd("qa")
  return
end
lazy.load({ plugins = { "mason.nvim", "mason-lspconfig.nvim", "nvim-lspconfig" } })
vim.cmd("doautocmd User VeryLazy")

local registry = require("mason-registry")
-- Refresca el registro (LazyVim lo hace en su ensure_installed)
registry.refresh()

local function instalando()
  for _, p in ipairs(registry.get_all_packages()) do
    if p:is_installing() then return true end
  end
  return false
end

-- Margen inicial para que LazyVim encole las instalaciones, luego espera a que acaben
vim.wait(15000, function() return false end, 500)
vim.wait(600000, function() return not instalando() end, 1000)
vim.cmd("qa")
