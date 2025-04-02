-- vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover({max_width = 80, border = "rounded"})<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>td', '<cmd>Telescope diagnostics<CR>', opts)
  -- lsp rename
  buf_set_keymap('n', '<leader><leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- lsp finder
  buf_set_keymap('n', 'gh', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
end

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e1e2e' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#c678dd', bg = '#1e1e2e' })

vim.diagnostic.config({
  -- General diagnostic options
  virtual_text = true,     -- Disable virtual text (optional)
  signs = true,             -- Enable signs for diagnostics
  underline = true,         -- Underline diagnostic lines
  update_in_insert = false, -- Disable updates in insert mode

  -- Float-specific settings
  float = {
    border = "rounded", -- Can be "single", "double", "rounded", "solid", "shadow"
    source = "always",  -- Always show diagnostic source in float
	max_width = 80,     -- Maximum width of a diagnostic float
    header = "",        -- Header for diagnostic float (optional)
    prefix = "",        -- Prefix for each diagnostic message
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  }
})

nvim_lsp.pyright.setup{
  on_attach = on_attach,
}

nvim_lsp.rust_analyzer.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                loadOutDirsFromCheck = true,
                allFeatures = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
        }
    },
    root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json"),
})

nvim_lsp.gopls.setup{
  on_attach = on_attach,
}

nvim_lsp.bashls.setup{
  on_attach = on_attach,
}

nvim_lsp.ccls.setup{
  on_attach = on_attach,
}

-- sudo npm install -g vls
nvim_lsp.vuels.setup{
  on_attach = on_attach,
  filetypes = {'vue'}
}

-- sudo npm install -g typescript typescript-language-server
nvim_lsp.ts_ls.setup{
  on_attach = on_attach,
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
}

nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

nvim_lsp.dartls.setup {
  on_attach = on_attach,
}

-- phpactor
nvim_lsp.phpactor.setup {
  on_attach = on_attach,
}
