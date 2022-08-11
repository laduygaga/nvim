function ToggleVExplorer()
	  vim.api.nvim_command('Lexplore')
	  vim.api.nvim_command('vertical resize 30')
end


-- toggle mouse
local is_mouse_enabled = 0
function ToggleMouse()
	if is_mouse_enabled == 0 then
		print("Mouse ON")
		vim.opt.mouse = 'a'
		is_mouse_enabled = 1
	else
		print("Mouse OFF")
		vim.opt.mouse = ''
		is_mouse_enabled = 0
	end
end


-- toggle colorscheme
local is_enable_colorscheme = 0
function ToggleColorscheme()
	if is_enable_colorscheme == 0 then
		print("colorscheme onedark")
		vim.api.nvim_command('colorscheme onedark')
		is_enable_colorscheme = 1
	else
		print("colorscheme peachpuff")
		vim.api.nvim_command('colorscheme peachpuff')
		is_enable_colorscheme = 0
	end
end


-- toggle wrap line
local is_wrap = 0
function ToggleWrap()
	if is_wrap == 1 then
		print("Wrap OFF")
		vim.api.nvim_command('setlocal nowrap')
		vim.api.nvim_command('set virtualedit=all')
		is_wrap = 0
	else
		print("Wrap ON")
		vim.api.nvim_command('setlocal wrap linebreak nolist')
		vim.api.nvim_command('set virtualedit=')
		vim.api.nvim_command('setlocal display+=lastline')
		is_wrap = 1
	end
end


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

