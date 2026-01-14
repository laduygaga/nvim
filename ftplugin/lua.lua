-- Lua specific settings
vim.keymap.set('n', '<leader>2', ':w<CR>:%w !lua %<CR>', { buffer = true })

-- Comment mappings
vim.keymap.set('v', 'g//', ':norm 0i-- <esc>', { buffer = true, silent = true })
vim.keymap.set('v', 'g/', ':norm 0xxx<esc>', { buffer = true, silent = true })

-- DAP mappings
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { buffer = true, silent = true })
vim.keymap.set('v', '<CR>', function() require("dapui").eval() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F6>', function() require("osv").run_this() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>ds', function() require('dap').close() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { buffer = true, silent = true })
