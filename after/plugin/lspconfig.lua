-- Global LSP Capabilities helper (integrates blink.cmp)
function _G.get_lsp_capabilities(override)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end
  if override then
    capabilities = vim.tbl_deep_extend("force", capabilities, override)
  end
  return capabilities
end

-- LSP Keymaps via LspAttach autocmd (applies to ALL language servers automatically)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", { buffer = ev.buf, desc = "LSP Definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", { buffer = ev.buf, desc = "LSP Implementation" })
    vim.keymap.set("n", "<leader><leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader><leader>td", "<cmd>FzfLua diagnostics_document<CR>", opts)
    vim.keymap.set("n", "<leader><leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gh", "<cmd>FzfLua lsp_references<CR>", opts)
    vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end, opts)
  end,
})

-- Auto-reload buffers when edited externally (e.g. by OpenCode, git, formatting scripts)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("AutoChecktime", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- UI Highlights
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#c678dd", bg = "#1e1e2e" })
vim.o.winborder = "rounded"

-- Diagnostic Configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,

  float = {
    border = "rounded",
    source = "always",
    max_width = 80,
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})
