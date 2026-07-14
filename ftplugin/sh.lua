-- Other language executor mappings
vim.keymap.set('n', '<leader>2', ':%w !bash<CR>', { buffer = true })
vim.keymap.set('v', '<leader>2', '!bash<CR>', { buffer = true })

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { '.git' }) or (fname ~= '' and vim.fs.dirname(fname)) or vim.fn.getcwd())
  end,
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
})
vim.lsp.enable('bashls')
