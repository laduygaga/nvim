vim.cmd [[
if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	let g:LargeFile = 2 * 1024 * 1024
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal nonumber norelativenumber noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
		" autocmd BufReadPre *.html set eventignore+=FileType
	augroup END
endif
]]
