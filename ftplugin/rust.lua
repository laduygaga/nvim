-- Rust executor mappings  
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear<CR>:!cargo run<CR>', { buffer = true, silent = true })

-- LSP configuration for Rust
vim.lsp.config('rust_analyzer', {
    on_attach = _G.on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        ["rust-analyzer"] = {
            cargo = { loadOutDirsFromCheck = true, allFeatures = false },
            procMacro = { enable = true },
            checkOnSave = { command = "check" }, -- Reduced from clippy
        }
    },
})
vim.lsp.enable('rust_analyzer')
