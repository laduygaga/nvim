-- Enable treesitter highlighting
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    
    -- Skip if no filetype or special buffers
    if ft == "" or vim.bo[buf].buftype ~= "" then
      return
    end
    
    -- Check for large files
    if vim.fn.line("$") > 10000 then
      return
    end
    
    -- Check for long lines in html/js
    if ft == "html" or ft == "javascript" then
      for i = 1, vim.fn.line("$") do
        local line = vim.fn.getline(i)
        if #line > 200 then
          return
        end
      end
    end
    
    -- Try to start treesitter highlighting
    local ok = pcall(vim.treesitter.start, buf, ft)
    if not ok then
      -- Fallback to syntax highlighting
      vim.bo[buf].syntax = "on"
    end
  end,
})

-- Legacy config (kept for compatibility)
require('nvim-treesitter').setup {
  highlight = {
    enable = true,
	disable = {},  -- Handled by autocmd above
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss",
	"python",
	"c",
	"cpp",
	"go",
	"bash",
	"lua",
	"rust",
	"typescript",
	"javascript",
	"vue",
	"proto",
	"regex",
	"latex",
	"markdown",
	"perl",
	"haskell",
	"ruby",
	"graphql",
	"cmake",
	"vim",
	"dockerfile",
	"dart",
	"vimdoc",
	"query",
	"diff",
  },
  auto_install = true,  -- Auto-install parsers on new machine
}

-- Auto-install parsers on first setup
local function ensure_parsers_installed()
  local installed = require('nvim-treesitter').get_installed()
  if #installed == 0 then
    vim.notify("Installing treesitter parsers for first time...", vim.log.levels.INFO)
    -- Install essential parsers
    local essential = {'lua', 'vim', 'vimdoc', 'query', 'python', 'javascript', 'typescript', 'bash', 'json', 'markdown'}
    for _, lang in ipairs(essential) do
      vim.schedule(function()
        require('nvim-treesitter').install(lang)
      end)
    end
  end
end

-- Run on startup
vim.defer_fn(ensure_parsers_installed, 100)

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
