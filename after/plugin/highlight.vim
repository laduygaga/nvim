" Aerial.nvim
hi link AerialClass Type
hi link AerialClassIcon Special
hi link AerialFunction Special
hi AerialFunctionIcon guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

" There's also this group for the cursor position
hi link AerialLine QuickFixLine
" If highlight_mode="split_width", you can set a separate color for the
" non-current location highlight
hi AerialLineNC guibg=Gray

" You can customize the guides (if show_guide=true)
hi link AerialGuide Comment
" You can set a different guide color for each level
hi AerialGuide1 guifg=Red
hi AerialGuide2 guifg=Blue
