if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
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
  },
}

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF
