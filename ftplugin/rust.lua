-- Rust executor mappings  
vim.keymap.set('n', '<leader>2', ':w<CR>:!clear<CR>:!cargo run<CR>', { buffer = true, silent = true })

-- LSP configuration for Rust
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, 'blink.cmp')
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local crate = vim.fs.root(fname, { 'Cargo.toml', 'rust-project.json' })
      if not crate then
        on_dir(vim.fs.root(fname, { '.git' }))
        return
      end
      vim.system(
        { 'cargo', 'metadata', '--no-deps', '--format-version', '1', '--manifest-path', crate .. '/Cargo.toml' },
        { text = true, timeout = 15000 },
        function(out)
          local ws = crate
          if out.code == 0 and out.stdout then
            local ok, data = pcall(vim.json.decode, out.stdout)
            if ok and data and data.workspace_root then
              ws = vim.fs.normalize(data.workspace_root)
            end
          end
          on_dir(ws)
        end
      )
    end,
    single_file_support = true,
    on_attach = _G.on_attach,
    capabilities = capabilities,
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
