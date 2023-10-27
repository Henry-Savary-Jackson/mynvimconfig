---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'catppuccin'}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"


 --local lsp = require('lsp-zero').preset({})

--lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  --lsp.default_keymaps({buffer = bufnr})
--end)


--lsp.setup()

return M
