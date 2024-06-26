--
vim.cmd[[filetype plugin indent on]]
vim.cmd[[syntax on]]

-- colorscheme
vim.cmd[[colorscheme peachpuff]]
vim.cmd[[set notermguicolors]]

-- visual
vim.cmd[[hi Normal ctermfg=None ctermbg=None guibg=None]]
vim.cmd[[hi CursorLine cterm=NONE ctermbg=227]]
vim.cmd[[hi Visual ctermfg=NONE ctermbg=11]]
vim.cmd[[hi MatchParen ctermfg=Black ctermbg=LightCyan]]
vim.cmd[[hi CursorLineNr term=none cterm=none ctermfg=202]]
vim.cmd[[hi Search term=none cterm=none ctermfg=Black ctermbg=LightCyan]]

-- floaterm
vim.cmd[[highlight FloatermBorder guibg=orange guifg=cyan]]
vim.cmd[[let g:floaterm_width=0.9]]


-- Ag
vim.cmd[[let g:ag_working_path_mode="r"]]

-- fix paste mode
vim.cmd[[let &t_SI .= "\<Esc>[?2004h"]]
vim.cmd[[let &t_EI .= "\<Esc>[?2004l"]]

-- cursor settings
-- 1 -> blinking block
-- 2 -> solid block
-- 3 -> blinking underscore
-- 4 -> solid underscore
-- 5 -> blinking vertical bar
-- 6 -> solid vertical bar
vim.cmd[[let &t_SI.="\e[5 q"]]  -- SI = INSERT mode
vim.cmd[[let &t_SR.="\e[1 q"]]  -- SR = REPLACE mode
vim.cmd[[let &t_EI.="\e[1 q"]]  -- EI = EXIT INSERT mode



-- FZF use fd
-- vim.cmd[[let $FZF_DEFAULT_COMMAND = "fd --type f"]]
vim.cmd[[let $FZF_DEFAULT_COMMAND = "fd --no-ignore-vcs"]]

-- netrw
vim.cmd[[let g:netrw_banner=0]]
vim.cmd[[let g:netrw_liststyle=1]]
vim.cmd[[let g:netrw_list_hide = '^\..*']]
vim.cmd[[let g:netrw_hide = 1]]

-- coq
-- vim.cmd[[let g:coq_settings = { 'auto_start': 'shut-up' }]]

-- make tagbar in the left
vim.cmd('let g:tagbar_left = 1')
