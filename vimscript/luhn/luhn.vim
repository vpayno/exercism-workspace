"
" Given a number string, determine whether it's valid per the Luhn formula
"
" Example:
"
" :echo IsValid('055 444 285')
" 1
"
function! IsValid(code) abort
    " echom 'code: ' . a:code

    if a:code !~# '^[0-9 ]\+$'
        " echom 'error: bad char'
        return 0 " false
    endif

    let l:runes = split(a:code, '\zs')
    let l:digits1 = []
    let l:digits2 = []

    let l:i = 0
    let l:d = 0

    for l:d in l:runes
        if l:d =~# '^[0-9]$'
            let l:digits1 = [str2nr(l:d)] + l:digits1
        endif
    endfor

    let l:sum = 0
    for l:d in l:digits1
        let l:sum += l:d
    endfor

    if l:sum == 0 && len(l:digits1) <= 1
        " echom 'error: single zero'
        return 0 " v:false
    endif

    for l:d in l:digits1
        if l:i % 2 != 0
            let l:d *= 2
            if l:d > 9
                let l:d -= 9
            endif
            let l:digits2 += [d]
        else
            let l:digits2 += [d]
        endif

        let l:i += 1
    endfor

    let l:sum = 0
    for l:d in l:digits2
        let l:sum += l:d
    endfor

    " echom 'l:digits1: ' . '[' . join(l:digits1, ',') . ']'
    " echom 'l:digits2: ' . '[' . join(l:digits2, ',') . ']'
    " echom 'sum: ' . (l:sum % 10)

    return (l:sum % 10 == 0)
endfunction
