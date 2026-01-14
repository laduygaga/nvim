-- Dart executor mappings
vim.keymap.set('n', '<leader>2', ':w<CR>:%w !dart %<CR>', { buffer = true })
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
