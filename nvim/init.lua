require "core"

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

vim.wo.relativenumber = true
vim.g.python3_host_prog = "~/mynvimconfig/venv/bin/python3"
vim.g.loaded_python3_provider = 1

local venv_selector = require "venv-selector"

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*.py",
  callback = function()
    venv_selector.retrieve_from_cache()
    if venv_selector.get_active_venv() ~= nil then
      require("dap-python").setup(os.getenv "VIRTUAL_ENV" .. "/bin/python")
    end
  end,
  once = true,
})

local ls = require "luasnip"

ls.add_snippets("tex", {
  ls.parser.parse_snippet("inf", "\\infty"),
  ls.parser.parse_snippet("frac", "\\frac{$1}{$2}"),

  -- trig

  -- angles
  ls.parser.parse_snippet("theta", "\\theta"),
  ls.parser.parse_snippet("omega", "\\omega"),
  ls.parser.parse_snippet("alpha", "\\alpha"),
  ls.parser.parse_snippet("beta", "\\beta"),
  ls.parser.parse_snippet("ang", "\\ang"),

  -- sets
  ls.parser.parse_snippet("eof", "\\"),
  -- linear algebra
  ls.parser.parse_snippet("vecn", "\\overrightarrow{$1}"),
})
-- require('dap-python').setup(masonpath .. 'packages/debugpy/venv/bin/python')
vim.g.vimtex_view_method = "zathura"
