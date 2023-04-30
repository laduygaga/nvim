let g:colors = getcompletion('', 'color')
let g:colors_name = ""
func! NextColors()
	let g:colors_name = g:colors_name == '' ? 'default' : g:colors_name
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
	let g:colors_name = g:colors_name == '' ? 'default' : g:colors_name
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
nnoremap <F5> :exe "colo " .. NextColors()<CR>
nnoremap <F3> :exe "colo " .. PrevColors()<CR>
