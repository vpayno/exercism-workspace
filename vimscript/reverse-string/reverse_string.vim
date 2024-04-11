"
" Reverses the passed test
"
" Examples:
"
"   :echo Reverse('Exercism')
"   msicrexE
"
function! Reverse(text) abort
    let l:rtext = ''

    for s:item in split(a:text, '\zs')
        let l:rtext = s:item . l:rtext
    endfor

    return l:rtext
endfunction
