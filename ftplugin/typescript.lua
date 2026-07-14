-- TypeScript specific settings (same as JavaScript for DAP)
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
vim.keymap.set('n', '<leader>ds', function() require('dap').close() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { buffer = true, silent = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, 'blink.cmp')
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(vim.api.nvim_buf_get_name(bufnr), { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' })
      or vim.fn.getcwd())
  end,
  single_file_support = true,
  init_options = { hostInfo = 'neovim' },
  capabilities = capabilities,
})
vim.lsp.enable('ts_ls')
