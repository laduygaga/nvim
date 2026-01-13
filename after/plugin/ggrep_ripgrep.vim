" 1. Helper function to dry up the logic
function! s:fzf_rg(query, bang, dir)
  let l:spec = fzf#vim#with_preview({'dir': a:dir})
  call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(a:query),
    \ 1, l:spec, a:bang)
endfunction

" 2. Optimized Git Root search (uses a variable to avoid shell calls if possible)
command! -bang -nargs=* GRg
  \ call s:fzf_rg(<q-args>, <bang>0, fnamemodify(finddir('.git', '.;'), ':p:h:h'))

" 3. Current Directory search
command! -bang -nargs=* FRg
  \ call s:fzf_rg(<q-args>, <bang>0, getcwd())
