if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> \\f <cmd>Telescope find_files<cr>
nnoremap <silent> \\g <cmd>Telescope git_files<cr>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

