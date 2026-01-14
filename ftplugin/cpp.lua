-- C++ executor mappings
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>', { buffer = true })
