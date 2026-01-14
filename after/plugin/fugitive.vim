" Status line
" set statusline=%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}[L%l/%L,C%03v]
set statusline=[L%l/%L,C%03v]
" set winbar=%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}
set winbar=%f
set statusline+=%=
set statusline+=[%F]:
" Only show fugitive statusline if it's loaded
set statusline+=%{exists('*fugitive#statusline')?fugitive#statusline():''}
