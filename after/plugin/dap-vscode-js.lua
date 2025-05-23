local extension_path = "/home/duy/.local/share/nvim/site/pack/packer/opt/vscode-js-debug/"
require("dap-vscode-js").setup({
  debugger_path = extension_path, -- Path to vscode-js-debug installation.
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local dap = require("dap")
dap.adapters['pwa-node'] = {
  type = 'executable',
  command = 'node',
  -- IMPORTANT: Verify this path to vsDebugServer.js is correct for your js-debug-adapter installation
  -- You can check this path by running: ls -la ~/.local/share/nvim/mason/packages/js-debug-adapter/dist/src/vsDebugServer.js
  args = { extension_path .. 'out/dist/src/vsDebugServer.js' },
  -- The following options might be needed or beneficial, taken from common nvim-dap-vscode-js setups
  -- enriquecedores de configuracion (config enhancers)
  -- enrich_config = function(config, on_config)
  --   -- This is a placeholder, specific enrich_config might be needed if issues persist
  --   -- or if you were relying on nvim-dap-vscode-js for this.
  --   -- For basic attach/launch, it might not be strictly necessary.
  --   return config
  -- end,
}

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
	{
	  type = "pwa-node",
	  request = "launch",
	  name = "Launch file",
	  program = "${file}",
	  cwd = "${workspaceFolder}",
	},
	{
	  type = "pwa-node",
	  request = "attach",
	  name = "Attach",
	  processId = require'dap.utils'.pick_process,
	  cwd = "${workspaceFolder}",
	},
    {
      name = 'Attach to NestJS (9229)', -- A friendly name for the DAP selection menu
      type = 'pwa-node', -- Use 'pwa-node' for the built-in inspector.
      request = 'attach',
      port = 9229,
      host = '127.0.0.1', -- Or 'localhost'. If NestJS listens on 0.0.0.0, 127.0.0.1 can connect.
      cwd = vim.fn.getcwd(), -- Project root directory
      sourceMaps = true, -- Crucial for TypeScript projects
      protocol = 'inspector', -- Usually default for node2/node, but explicit is good
      localRoot = vim.fn.getcwd(), -- Root of your source files on your machine
      remoteRoot = vim.fn.getcwd(), -- Root of the executed files on the server (same if local)
                                    -- If NestJS runs from a 'dist' folder, and source maps are relative,
                                    -- this setup usually works. Adjust if breakpoints are not hit correctly.
      skipFiles = { -- Optional: helps avoid stepping into irrelevant code
          "<node_internals>/**",
          "${workspaceFolder}/node_modules/**",
      },
    },
  }
end
