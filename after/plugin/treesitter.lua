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
	-- disable for large files or html
	disable = function()
		if vim.bo.filetype == 'html' or vim.bo.filetype == 'javascript' then
			for i = 1, vim.fn.line("$") do
				local line = vim.fn.getline(i)
				if #line > 200 then
					return true
				end
			end
		end
		return vim.fn.line("$") > 10000
	end,
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
}

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
