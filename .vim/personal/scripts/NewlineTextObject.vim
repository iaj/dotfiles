" (empty) Newlines Text Object
" authors: bairui, raimondi
" 27 Apr 2011

" Provides two text-objects:
" an - to select all empty lines surrounding the curosr
" in - to select all but one of the empty lines surrounding the cursor
"
" These can be used with visual mode (van/vin) or any of the standard vim
" commands that take a text-object, like (d)elete & (c)hange.

" Bugs:
" * (not usr_41 certified) doesn't have the necessary goodies to allow user to
"    map his own keystrokes instead of vin/van

function! s:VAN()
  if search('\_s\+\%#\_s\+', 'bcnW')
   " In whitespace
    return "/.\<esc>ko?.\<esc>j:\<C-U>nohl\<CR>gv"
  else
   return "\<C-\>\<C-n>\<Esc>:\<C-U>nohl\<CR>gv"
  endif
endfunction

function! s:VIN()
  if search('.\_$\_s\zs\_s\+\%#\_s\+', 'bcnW') || search('\%#\_s\+', 'bcnW')
   " In multi-line whitespace
    return "/.\<esc>ko?.\<esc>jj:\<C-U>nohl\<CR>gv"
  else
    return "\<C-\>\<C-n>\<Esc>:\<C-U>nohl\<CR>gv"
  endif
endfunction

vnoremap <expr> an <SID>VAN()
vnoremap <expr> in <SID>VIN()
onoremap an :normal van<CR>
onoremap in :normal vin<CR>
