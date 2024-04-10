"
" This function takes a year and returns 1 if it's a leap year
" and 0 otherwise.
"
function! LeapYear(year) abort
  " the tests want 0->false, 1->true
  let l:true = 1
  let l:false = 0

  if a:year % 400 ==# 0
      return l:true
  endif

  if a:year % 100 ==# 0
      return l:false
  endif

  if a:year % 4 ==# 0
      return l:true
  endif

  return l:false
endfunction
