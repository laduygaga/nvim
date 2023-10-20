command! -range -nargs=0 Overline        call s:ToggleCombining(<line1>, <line2>, "\u0305")
command! -range -nargs=0 Underline       call s:ToggleCombining(<line1>, <line2>, "\u0332")
command! -range -nargs=0 DoubleUnderline call s:ToggleCombining(<line1>, <line2>, "\u0333")
command! -range -nargs=0 Strikethrough   call s:ToggleCombining(<line1>, <line2>, "\u0336")


function! s:ToggleCombining( line1, line2, character )

    let l:lines = getline(a:line1, a:line2)
    if len(l:lines) == 0
        return ''
    endif
    let l:text = join(l:lines, "\n")

    let l:cleanedText = ''
    let l:idx = 0
    while l:idx < len(l:text)
        let l:codepoint = nr2char(char2nr(l:text[l:idx :]))
        if l:codepoint !=# a:character
            let l:cleanedText .= l:codepoint
        endif

        let l:idx += len(l:codepoint)
    endwhile

    let l:finalText = ""
    if l:cleanedText !=# l:text
        let l:finalText = l:cleanedText
    else
        let l:finalText = substitute(l:text, '[^[:cntrl:]]', '&' . a:character, 'g')
    endif

    execute a:line1.','.a:line2.'s/\%V'.l:text.'/'.l:finalText.'/'
endfunction

function! FormatAndIndentHTML()
    " Step 1: Break HTML tags onto new lines
    execute 's/<[^>]*>/\r&\r/g'

    " Step 2: Remove empty lines
    execute 'g/^$/d'

    " Step 3: Re-indent the entire buffer
    normal! gg=G
endfunction
