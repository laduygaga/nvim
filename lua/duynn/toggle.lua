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
