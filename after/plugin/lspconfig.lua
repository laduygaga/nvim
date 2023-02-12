-- vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')

-- require("coq_3p") {
--   { src = "bc", short_name = "MATH", precision = 6 }, --require bc
--   -- { src = "cow", trigger = "!cow" },				  -- require cowsay
--   -- { src = "figlet", short_name = "BIG" },		  -- require figlet
--   {
--     src = "repl",
--     sh = "bash",
--     shell = { p = "perl", n = "node", ... },
--     max_lines = 99,
--     deadline = 500,
--     unsafe = { "rm", "poweroff", "mv", ... }
--   },
--   { src = "nvimlua", short_name = "nLUA" },
--   { src = "vimtex", short_name = "vTEX" },
--   { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
-- }

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>td', '<cmd>Telescope diagnostics<CR>', opts)
end

--nvim_lsp.tsserver.setup {
--  on_attach = on_attach,
--  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
--}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

nvim_lsp.pyright.setup{
  on_attach = on_attach,
}

nvim_lsp.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

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
  -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

-- npm install -g typescript typescript-language-server
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
}

nvim_lsp.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}


-- Setup the LSP server to attach when you edit an sg:// buffer
require("sg").setup {
  -- Pass your own custom attach function
  --    If you do not pass your own attach function, then the following maps are provide:
  --        - gd -> goto definition
  --        - gr -> goto references
  on_attach = on_attach,
}
