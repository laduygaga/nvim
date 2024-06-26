require'nvim-treesitter.configs'.setup {
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
  },
}

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
