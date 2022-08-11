vim.cmd[[
augroup vim_autocmd
	" Prevent Vim from clearing the clipboard on exit
	autocmd VimLeave * call system("xsel -ib", getreg('+'))
	" fix always tabs to spaces when start python file
	" fuck /usr/share/vim/vim74/ftplugin/python.vim
	" autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd Filetype python inoremap <silent>  <buffer> <leader>2 <Esc>:%w !python3<CR>
	autocmd Filetype python nnoremap <silent> <buffer> <leader>2 :%w !python3<CR>
	autocmd Filetype python vnoremap <silent> <buffer> <leader>2 !python3<CR>
	autocmd Filetype php inoremap <silent> <buffer> <leader>2 <Esc>:%w !php<CR>
	autocmd Filetype php nnoremap <silent> <buffer> <leader>2 :%w !php<CR>
	autocmd Filetype php vnoremap <silent> <buffer> <leader>2 !php<CR>
	autocmd Filetype sh inoremap <silent> <buffer> <leader>2 <Esc>:%w !bash<CR>
	autocmd Filetype sh nnoremap <silent> <buffer> <leader>2 :%w !bash<CR>
	autocmd Filetype sh vnoremap <silent> <buffer> <leader>2 !bash<CR>
	autocmd Filetype javascript inoremap <silent> <buffer> <leader>2 <Esc>:%w !node<CR>
	autocmd Filetype javascript nnoremap <silent> <buffer> <leader>2 :%w !node<CR>
	autocmd Filetype javascript vnoremap <silent> <buffer> <leader>2 !node<CR>
	autocmd Filetype perl inoremap <silent> <buffer> <leader>2 <Esc>:%w !perl<CR>
	autocmd Filetype perl nnoremap <silent> <buffer> <leader>2 :%w !perl<CR>
	autocmd Filetype perl vnoremap <silent> <buffer> <leader>2 !perl<CR>
	autocmd Filetype c nnoremap  <leader>2 :w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype c inoremap  <leader>2 <Esc>:w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype cpp nnoremap  <leader>2 :w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype cpp inoremap  <leader>2 <Esc>:w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>
	autocmd Filetype rust nnoremap	<leader>2 :w<CR>:!clear; rustc % <CR>:!./%:r<CR>
	autocmd Filetype rust inoremap	<leader>2 <Esc>:w<CR>:!clear; rustc % <CR>:!./%:r<CR>
	autocmd Filetype go inoremap <silent> <buffer> <leader>2 <Esc>:w<CR>:%w !go run %<CR>
	autocmd Filetype go nnoremap <silent> <buffer> <leader>2 :w<CR>:%w !go run %<CR>
	autocmd Filetype lua inoremap <silent> <buffer> <leader>2 <Esc>:w<CR>:%w !lua %<CR>
	autocmd Filetype lua nnoremap <silent> <buffer> <leader>2 :w<CR>:%w !lua %<CR>

	" Debugger keymaps
	" use nvim-dap
	"
	"PYTHON
	autocmd Filetype python nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
	autocmd Filetype python nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>
	autocmd Filetype python nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	autocmd Filetype python vnoremap <silent> <CR> :lua require("dapui").eval()<CR>
	autocmd Filetype python nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
	autocmd Filetype python nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>
	autocmd Filetype python nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>
	autocmd Filetype python nnoremap <silent> <F10> :lua require'dap'.step_out()<CR>
	autocmd Filetype python nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>
	autocmd Filetype python nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>
	autocmd Filetype python nnoremap <silent> <leader>df :lua require('dap-python').test_method()<CR>
	autocmd Filetype python nnoremap <silent> <leader>do :lua require('dap-python').test_class()<CR>

	"GO 
	autocmd Filetype go nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
	autocmd Filetype go nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>
	autocmd Filetype go nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	autocmd Filetype go vnoremap <silent> <CR> :lua require("dapui").eval()<CR>
	autocmd Filetype go nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
	autocmd Filetype go nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>
	autocmd Filetype go nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>
	autocmd Filetype go nnoremap <silent> <F10> :lua require'dap'.step_out()<CR>
	autocmd Filetype go nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>
	autocmd Filetype go nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>

	" LUA
	autocmd Filetype lua nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
	autocmd Filetype lua nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>
	autocmd Filetype lua nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	autocmd Filetype lua vnoremap <silent> <CR> :lua require("dapui").eval()<CR>
	autocmd Filetype lua nnoremap <silent> <F5> :lua require"osv".run_this()<CR>
	autocmd Filetype lua nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
	autocmd Filetype lua nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>
	autocmd Filetype lua nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>
	autocmd Filetype lua nnoremap <silent> <F10> :lua require'dap'.step_out()<CR>
	autocmd Filetype lua nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>
	autocmd Filetype lua nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>

	" restore place in file from previous session
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	" setf dosini
	autocmd BufNewFile,BufRead *.conf setf dosini

augroup END

]]

-- if largefile
vim.cmd[[
if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	let g:LargeFile = 1024 * 1024 * 10
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
	augroup END
endif
]]


--  extend GGREP, ripgrep
vim.cmd[[
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=* GRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* FRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': systemlist('pwd')[0]}), <bang>0)
]]
