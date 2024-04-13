"
" Write a function to convert Arabic numbers to Roman numerals.
"
" Examples:
"
"   :echo ToRoman(1990)
"   MCMXC
"
"   :echo ToRoman(2008)
"   MMVIII
"
function! ToRoman(number) abort
  let l:d2r = {
    \ 1: 'I',
    \ 4: 'IV',
    \ 5: 'V',
    \ 9: 'IX',
    \ 10: 'X',
    \ 40: 'XL',
    \ 50: 'L',
    \ 90: 'XC',
    \ 100: 'C',
    \ 400: 'CD',
    \ 500: 'D',
    \ 900: 'CM',
    \ 1000: 'M',
    \ }

  let l:register = a:number
  let l:roman = ''

  " They keys may look like integers; However, they're strings.
  let l:int_keys = []
  for l:str_key in keys(l:d2r)
      let l:int_keys = l:int_keys + [str2nr(l:str_key)]
  endfor

  " the n function sorts numerically
  let l:rkeys = reverse(sort(l:int_keys, 'n'))
  " echom 'keys: ' . string(l:rkeys)

  " the reversed sort order is preserved in l:rkeys below
  for l:digits in l:rkeys
      let l:letter = l:d2r[l:digits]

      while l:register >= l:digits
          let l:roman = l:roman . l:letter
          let l:register -= l:digits
      endwhile
  endfor

  return l:roman
endfunction
