vim.api.nvim_set_keymap("i", "<C-f>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
  -- ["*"] = true,
  ["javascript"] = true,
  ["sql"] = true,
  ["html"] = true,
  ["css"] = true,
  ["typescript"] = true,
  ["lua"] = true,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
  ["sh"] = true,
  ["vim"] = true,
  ["php"] = true,
  ["yaml"] = true,
  ["dart"] = true,
  ["gs"] = true,
}


vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { silent = true, expr = true })
