local home = os.getenv('HOME')
local jdtls = require('jdtls')
-- my git repo containing my neovim config, with my lomkok jar, jdtls install location, java-debug install location, vscode-java-test location
local nvim_config_dir = home .. "/mynvimconfig"
-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local bundles = {
  vim.fn.glob('~/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.49.0.jar'),
}

vim.list_extend(bundles, vim.split(vim.fn.glob("~/vscode-java-test/server/*.jar", 1), "\n"))


print("yo fuck you ")

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)

  
vim.api.nvim_set_keymap('n', "<leader>;b" , "<cmd>lua require'dap'.toggle_breakpoint()<cr>",{noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;c", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;l", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;r', "<cmd>lua require'dap'.clear_breakpoints()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;a', '<cmd>Telescope dap list_breakpoints<cr>', {noremap=true})

vim.api.nvim_set_keymap('n',"<leader>;dc", "<cmd>lua require'dap'.continue()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;dj", "<cmd>lua require'dap'.step_over()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;dk", "<cmd>lua require'dap'.step_into()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;do", "<cmd>lua require'dap'.step_out()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;dd', "<cmd>lua require'dap'.disconnect()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;dt', "<cmd>lua require'dap'.terminate()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;dr", "<cmd>lua require'dap'.repl.toggle()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n',"<leader>;dl", "<cmd>lua require'dap'.run_last()<cr>", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;d?', " require'dap.ui.widgets'.centered_float(widgets.scopes)", {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;df', '<cmd>Telescope dap frames<cr>', {noremap=true})
vim.api.nvim_set_keymap('n','<leader>;dh', '<cmd>Telescope dap commands<cr>', {noremap=true})
  -- Regular Neovim LSP client keymappings
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
  nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
  nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  nnoremap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")
  nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
  nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
  nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
  nnoremap("<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
nnoremap("<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
  -- Java extensions provided by jdtls
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")

  -- nvim-dap
  
  vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })
end

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  root_dir = root_dir,
  on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  filetypes = { "java"},
  -- for a list of options
  settings = {
    java = {
      format = {
        settings = {
          -- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- How code generation should act
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk"
          },
        }
      }
    }
  },
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
  cmd = {
     nvim_config_dir .. "/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls",
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '-Xbootclasspath/a:'.. nvim_config_dir ..'/lombok.jar',
    '-javaagent:' ..  nvim_config_dir .. '/lombok.jar',
    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    '-jar', vim.fn.glob( nvim_config_dir .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'),
    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    '-configuration' , nvim_config_dir .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',

    -- Use the workspace_folder defined above to store data for this project
    '-data', workspace_folder,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  },

  init_options = {
    bundles = bundles
  },
}
require('jdtls').start_or_attach(config)
return config
-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
