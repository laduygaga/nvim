-- C++ executor mappings
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>', { buffer = true })

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'c.doxygen', 'cpp', 'cpp.doxygen', 'objc', 'objcpp', 'cuda' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac' })
      or vim.fs.root(fname, { '.git' })
      or vim.fn.getcwd())
  end,
  single_file_support = true,
  capabilities = _G.get_lsp_capabilities(),
})
vim.lsp.enable('clangd')
