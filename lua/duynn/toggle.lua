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
local is_wrap = 1
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


function ToggleTermguicolors()
  if vim.o.termguicolors then
    vim.o.termguicolors = false
    print("termguicolors: OFF (256 Colors)")
  else
    vim.o.termguicolors = true
    print("termguicolors: ON (True Color)")
  end
end


function ToggleJSON()
  -- CRITICAL: Exit visual mode to force Neovim to update the '< and '> marks
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "x", true)

  -- Now get the correct start and end rows of your visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Read the selected lines from the buffer
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local input_text = table.concat(lines, "\n")

  -- Check if the total selection is a single line (already minified)
  local is_minified = (start_line == end_line) and string.match(input_text, "^%s*[%[{].*[%]}]%s*$")

  -- Determine the correct jq arguments
  local jq_cmd = is_minified and "jq ." or "jq -c ."

  -- Run jq on the selected text
  local output = vim.fn.system(jq_cmd, input_text)

  if vim.v.shell_error == 0 then
    -- Clean up trailing whitespace/newlines from shell output
    output = string.gsub(output, "%s*$", "")
    
    -- Split the output back into an array of lines (needed for pretty-printed JSON)
    local output_lines = {}
    for s in string.gmatch(output, "[^\r\n]+") do
      table.insert(output_lines, s)
    end

    -- Replace the selected range with the formatted result
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, output_lines)
  else
    print("jq Error: " .. output)
  end
end
