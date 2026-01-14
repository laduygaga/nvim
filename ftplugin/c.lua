-- C executor mappings
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>', { buffer = true })
