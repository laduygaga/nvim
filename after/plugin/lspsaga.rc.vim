if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  border_style = "round",
}

EOF

nnoremap <silent> ]e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_prev<CR>
" nnoremap <silent> <C-j> :Lspsaga open_floaterm<CR>
" tnoremap <silent> <C-j> <C-\><C-n>:Lspsaga close_floaterm<CR>
nnoremap <silent> <C-j> :FloatermToggle<CR>
tnoremap <silent> <C-j> <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent><leader><leader>r :Lspsaga rename<CR>
" nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <C-k> <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
