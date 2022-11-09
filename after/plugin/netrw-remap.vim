let g:netrw_localrmdir='rm -r'
let g:netrw_keepdir=0
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw nmap <buffer> h -
    autocmd filetype netrw nmap <buffer> l <CR>
	" newfile: %
	" newdir: d
	" rename: R
	" delete: D
	" preview: p
	" previous: u
	" next: c-r
	" copy: mt mf mc - mark_target mark_file_to_copy paste
	" cycle sort: s
	" cycle list style: i
augroup END
