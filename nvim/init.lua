require "core"
vim.g.python3_host_prog = "~/mynvimconfig/venv/bin/python3"
vim.g.loaded_python3_provider = 1
local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.g.python3_host_prog = "~/mynvimconfig/venv/bin/python3"
vim.g.loaded_python3_provider = 0

require "snippets"

-- require('dap-python').setup(masonpath .. 'packages/debugpy/venv/bin/python')
vim.g.vimtex_view_method = "zathura"
vim.wo.relativenumber = true
vim.o.conceallevel = 1
vim.g.tex_conceal = "abdmg"
