-- Rust executor mappings  
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear<CR>:!cargo run<CR>', { buffer = true, silent = true })

-- LSP configuration for Rust
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, 'blink.cmp')
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config('rust_analyzer', {
    on_attach = _G.on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = { loadOutDirsFromCheck = true, allFeatures = false },
            procMacro = { enable = true },
            checkOnSave = { command = "check" }, -- Reduced from clippy
        }
    },
})
vim.lsp.enable('rust_analyzer')
