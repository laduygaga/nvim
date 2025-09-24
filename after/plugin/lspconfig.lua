-- vim.lsp.set_log_level("debug")

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true, buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader><leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader><leader>td', '<cmd>Telescope diagnostics<CR>', opts)
  -- lsp rename
  vim.keymap.set('n', '<leader><leader>r', vim.lsp.buf.rename, opts)
  -- lsp finder
  vim.keymap.set('n', 'gh', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
end

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e1e2e' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#c678dd', bg = '#1e1e2e' })
vim.o.winborder = 'rounded' -- or 'single', 'double', 'solid', 'none'

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

-- Python
vim.lsp.config('pyright', { on_attach = on_attach, })
vim.lsp.enable('pyright')

-- Rust
vim.lsp.config('rust_analyzer', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = { loadOutDirsFromCheck = true, allFeatures = true },
            procMacro = { enable = true },
            checkOnSave = { command = "clippy" },
        }
    },
})
vim.lsp.enable('rust_analyzer')

-- Go
vim.lsp.config('gopls', {on_attach = on_attach,})
vim.lsp.enable('gopls')

-- Lua
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  settings = { Lua = { diagnostics = { globals = {'vim'}, }, }, },
})
vim.lsp.enable('lua_ls')

-- Add more servers here as needed...
vim.lsp.config('bashls', {on_attach = on_attach,})
vim.lsp.enable('bashls')

vim.lsp.config('ccls', {on_attach = on_attach,})
vim.lsp.enable('ccls')

-- sudo npm install -g vls
vim.lsp.config('vuels', {on_attach = on_attach, filetypes = {'vue'}})
vim.lsp.enable('vuels')

-- sudo npm install -g typescript typescript-language-server
-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
})
vim.lsp.enable('ts_ls')

vim.lsp.config('dartls', {on_attach = on_attach,})
vim.lsp.enable('dartls')

-- phpactor
vim.lsp.config('phpactor', {on_attach = on_attach,})
vim.lsp.enable('phpactor')

vim.lsp.config('cssls', { on_attach = on_attach, })
vim.lsp.enable('cssls')

vim.lsp.config('html', { on_attach = on_attach, })
vim.lsp.enable('html')

-- omnisharp
vim.lsp.config('omnisharp',{on_attach=on_attach,cmd={"omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid())},})
