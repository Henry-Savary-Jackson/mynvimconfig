local dap = require "dap"
local mason_registry = require "mason-registry"

local js_debug_executable = mason_registry.get_package("js-debug-adapter"):get_install_path()
  .. "/js-debug/src/dapDebugServer.js"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "8213",
  executable = {
    command = "node",
    args = { js_debug_executable, "8213", "127.0.0.1" },
  },
}

for _, lang in ipairs { "typescript", "javascript" } do
  dap.configurations[lang] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end
