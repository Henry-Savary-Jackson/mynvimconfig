local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"},
 
    ["<leader>dc"] = {"<cmd> DapContinue <CR>"},

    ["<leader>dsi"] = {"<cmd> DapStepInto <CR>"},

    ["<leader>dso"] = {"<cmd> DapStepOver <CR>"},
    
    ["<leader>dsu"] = {"<cmd> DapStepOut <CR>"},

    ["<leader>dt"] = {"<cmd> DapTerminate <CR>"},
  }

}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dse"] = {
      function()
        require('dap-python').setup(os.getenv("VIRTUAL_ENV") .."/bin/python" )
      end
    },
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
