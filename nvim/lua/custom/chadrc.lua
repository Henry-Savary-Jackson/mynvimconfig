---@type ChadrcConfig
local M = {}
M.ui = { theme = "catppuccin" }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

local enable_providers = {
  "python3_provider",
  -- and so on
}
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
--local lsp = require('lsp-zero').preset({})

--lsp.on_attach(function(client, bufnr)
-- see :help lsp-zero-keybindings
-- to learn the available actions
--lsp.default_keymaps({buffer = bufnr})
--end)

--lsp.setup()

return M
