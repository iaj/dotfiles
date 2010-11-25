" barry arthur
" 6 Aug 2010
"
" Number Text Object (Integers only)
"
function! s:VAN()
  if search('\m\d\+\%#\d\+\d\+', 'bcnW')
    " inside a number
    return '?\d\+o/[^0-9]\|$h'"
  elseif search('\m\([^0-9]\|^\)\zs\%#\d\+', 'bcnW')
    " at the start of a number
    return '/[^0-9]\|$h'
  elseif search('\m\d\+\%#', 'bcnW')
    " at the end of a number
    return '?\d\+'
  else
    return "\<C-\>\<C-n>\<Esc>"
  endif
endfunction

function! s:VIN()
  let van = s:VAN()
  return van
endfunction

vnoremap <expr> an <SID>VAN()
vnoremap <expr> in <SID>VIN()
onoremap an :normal van<CR>
onoremap in :normal vin<CR>

finish

12345ax
ax12345
ax12345ax
ax 12345 ax
