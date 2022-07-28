if !exists('g:lspconfig')
  finish
endif

lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

require("coq_3p") {
  { src = "bc", short_name = "MATH", precision = 6 }, --require bc
  -- { src = "cow", trigger = "!cow" },				  -- require cowsay
  -- { src = "figlet", short_name = "BIG" },		  -- require figlet
  {
    src = "repl",
    sh = "bash",
    shell = { p = "perl", n = "node", ... },
    max_lines = 99,
    deadline = 500,
    unsafe = { "rm", "poweroff", "mv", ... }
  },
  { src = "nvimlua", short_name = "nLUA" },
  { src = "vimtex", short_name = "vTEX" },
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
}

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
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>td', '<cmd>Telescope diagnostics<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  -- if client.resolved_capabilities.document_formatting then
  --   vim.api.nvim_command [[augroup Format]]
  --   vim.api.nvim_command [[autocmd! * <buffer>]]
  --   vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
  --   vim.api.nvim_command [[augroup END]]
  -- end


end

-- nvim_lsp.flow.setup {
--   on_attach = on_attach
-- }

--nvim_lsp.tsserver.setup {
--  on_attach = on_attach,
--  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
--}

nvim_lsp.pyright.setup{
  on_attach = on_attach,
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

-- npm install -g @volar/vue-language-server
-- nvim_lsp.volar.setup{
--   on_attach = on_attach,
--   -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
-- }

-- sudo npm install -g vls
nvim_lsp.vuels.setup{
  on_attach = on_attach,
  -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

-- npm install -g typescript typescript-language-server
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
}

-- pms lua-language-server
-- nvim_lsp.sumneko_lua.setup {
--   on_attach = on_attach,
-- }
nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

-- nvim_lsp.diagnosticls.setup {
--   on_attach = on_attach,
--   filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
--   init_options = {
--     linters = {
--       eslint = {
--         command = 'eslint_d',
--         rootPatterns = { '.git' },
--         debounce = 100,
--         args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
--         sourceName = 'eslint_d',
--         parseJson = {
--           errorsRoot = '[0].messages',
--           line = 'line',
--           column = 'column',
--           endLine = 'endLine',
--           endColumn = 'endColumn',
--           message = '[eslint] ${message} [${ruleId}]',
--           security = 'severity'
--         },
--         securities = {
--           [2] = 'error',
--           [1] = 'warning'
--         }
--       },
--     },
--     filetypes = {
--       javascript = 'eslint',
--       javascriptreact = 'eslint',
--       typescript = 'eslint',
--       typescriptreact = 'eslint',
--     },
--     formatters = {
--       eslint_d = {
--         command = 'eslint_d',
--         args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
--         rootPatterns = { '.git' },
--       },
--       prettier = {
--         command = 'prettier',
--         args = { '--stdin-filepath', '%filename' }
--       }
--     },
--     formatFiletypes = {
--       css = 'prettier',
--       javascript = 'eslint_d',
--       javascriptreact = 'eslint_d',
--       json = 'prettier',
--       scss = 'prettier',
--       less = 'prettier',
--       typescript = 'eslint_d',
--       typescriptreact = 'eslint_d',
--       json = 'prettier',
--       markdown = 'prettier',
--     }
--   }
-- }
-- 
-- -- icon
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     -- This sets the spacing and the prefix, obviously.
--     virtual_text = {
--       spacing = 4,
--       prefix = ''
--     }
--   }
-- )

EOF
