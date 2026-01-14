-- Haskell executor mappings
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear;ghc -dynamic %:p<CR>:!./%:r<CR>', { buffer = true })
