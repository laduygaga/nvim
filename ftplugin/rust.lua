-- Rust executor mappings  
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear<CR>:!cargo run<CR>', { buffer = true, silent = true })

-- LSP configuration for Rust
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_dir = function(bufnr)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      return vim.fs.root(fname, { 'Cargo.toml', 'rust-project.json', '.git' })
    end,
    single_file_support = true,
    capabilities = require("duynn.lsp").get_capabilities(),
    before_init = function(init_params, config)
      if config.settings and config.settings['rust-analyzer'] then
        init_params.initializationOptions = config.settings['rust-analyzer']
      end
    end,
    settings = {
        ["rust-analyzer"] = {
            cargo = { loadOutDirsFromCheck = true, allFeatures = false },
            procMacro = { enable = true },
            checkOnSave = true,
            check = { command = "check" },
        }
    },
})
vim.lsp.enable('rust_analyzer')
