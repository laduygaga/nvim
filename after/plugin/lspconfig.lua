-- vim.lsp.set_log_level("debug")

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true, buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', { desc = 'LSP Definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', { desc = 'LSP Implementation' })
  vim.keymap.set('n', '<leader><leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader><leader>td', '<cmd>FzfLua diagnostics_document<CR>', opts)
  -- lsp rename
  vim.keymap.set('n', '<leader><leader>r', vim.lsp.buf.rename, opts)
  -- lsp finder
  vim.keymap.set('n', 'gh', '<cmd>FzfLua lsp_references<CR>', opts)
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
