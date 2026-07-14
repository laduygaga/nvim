-- Go specific settings
vim.keymap.set('n', '<leader>2', ':w<CR>:%w !go run %<CR>', { buffer = true })
vim.keymap.set('n', '<leader>f', ':%!gofmt<cr>', { buffer = true })

-- Comment mappings
vim.keymap.set('v', 'g//', ':norm 0i// <esc>', { buffer = true, silent = true })
vim.keymap.set('v', 'g/', ':norm 0xxx<esc>', { buffer = true, silent = true })

-- DAP mappings
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { buffer = true, silent = true })
-- Visual mode eval - use old vnoremap style for proper behavior
vim.cmd([[vnoremap <buffer> <silent> <CR> :lua require("dapui").eval()<CR>]])
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { buffer = true, silent = true })
-- vim.keymap.set('n', '<leader>ds', function() require('dap').close() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>ds', function() require('dap').terminate() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { buffer = true, silent = true })

-- LSP configuration for Go
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(vim.api.nvim_buf_get_name(bufnr), { 'go.work', 'go.mod', '.git' }))
  end,
  single_file_support = true,
  on_attach = _G.on_attach,
  flags = { debounce_text_changes = 200 },
  settings = {
    gopls = {
      analyses = {
        staticcheck = false, -- Optimization
        unusedparams = false, -- costly per keystroke on large codebases
        nilness = false,
        shadow = false,
        unusedwrite = false,
        unreachable = false,
      },
      staticcheck = false, -- Optimization
      directoryFilters = {
        '-**/vendor',
        '-**/testdata',
        '-**/node_modules',
      },
      -- set false only if you open a subdir of a big module (reduces workspace scope)
      expandWorkspaceToModule = false,
    },
  },
})
vim.lsp.enable('gopls')
