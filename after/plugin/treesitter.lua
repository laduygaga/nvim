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
    
    -- Check for large files (but allow protobuf files)
    local is_protobuf = vim.fn.expand('%'):match("%.pb%.go$") ~= nil
    if vim.fn.line("$") > 10000 and not is_protobuf then
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
  auto_install = true,  -- Auto-install parsers when opening files
}

-- Auto-install all parsers from ensure_installed list on first setup
local function ensure_parsers_installed()
  local installed = require('nvim-treesitter').get_installed()
  local config = require('nvim-treesitter').setup_config or {}
  local ensure_installed = config.ensure_installed or {
    "tsx", "toml", "fish", "php", "json", "yaml", "swift", "html", "scss",
    "python", "c", "cpp", "go", "bash", "lua", "rust", "typescript", "javascript",
    "vue", "proto", "regex", "latex", "markdown", "perl", "haskell", "ruby",
    "graphql", "cmake", "vim", "dockerfile", "dart", "vimdoc", "query", "diff"
  }
  
  -- Check if we need to install parsers
  if #installed < 10 then
    vim.notify("Installing treesitter parsers (this may take a minute)...", vim.log.levels.INFO)
    
    -- Install all parsers from ensure_installed
    for _, lang in ipairs(ensure_installed) do
      vim.schedule(function()
        local ok, err = pcall(require('nvim-treesitter').install, lang)
        if not ok then
          vim.notify("Failed to install " .. lang .. " parser: " .. tostring(err), vim.log.levels.WARN)
        end
      end)
    end
  end
end

-- Run on startup with delay to not block UI
vim.defer_fn(ensure_parsers_installed, 500)

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
