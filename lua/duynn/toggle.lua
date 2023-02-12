function ToggleVExplorer()
	  vim.api.nvim_command('Lexplore')
	  -- vim.api.nvim_command('vertical resize 30')
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
		vim.cmd[[colorscheme peachpuff]]
		vim.cmd[[highlight Normal ctermfg=None ctermbg=None]]
		vim.cmd[[highlight CursorLine cterm=NONE ctermbg=227]]
		vim.cmd[[highlight Visual ctermfg=NONE ctermbg=11]]
		vim.cmd[[highlight MatchParen ctermfg=Black ctermbg=LightCyan]]
		vim.cmd[[highlight CursorLineNr term=none cterm=none ctermfg=202]]
		vim.cmd[[highlight Search term=none cterm=none ctermfg=Black ctermbg=LightCyan]]

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


-- toggle expandtab then retab
local is_expandtab = 0
function ToggleExpandtab()
	if is_expandtab == 1 then
		print("Expandtab OFF")
		vim.api.nvim_command('setlocal noexpandtab')
		vim.api.nvim_command('setlocal tabstop=4')
		vim.api.nvim_command('%retab!')
		is_expandtab = 0
	else
		print("Expandtab ON")
		vim.api.nvim_command('setlocal expandtab')
		vim.api.nvim_command('setlocal tabstop=4')
		vim.api.nvim_command('retab')
		is_expandtab = 1
	end
end
