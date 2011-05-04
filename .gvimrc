if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  "map <silent> <D-e> :FufBookmarkFile<CR>  
  "map <silent> <D-r> :FufMruFile<CR>  
  map <silent> <D-t> :FufTag<CR>  
  map <silent> <D-T> :FufTagWithCursorWord<CR>  
  "macmenu &File.Open\ Tab\.\.\. key=<nop>
  "map <S-D-t> :CommandT<CR>
  "macmenu Window.Next\ Tab key=<nop>

  "unbind the Find Key combination
  macm &Edit.Find.Find\.\.\. key=<nop>
  macm Window.Toggle\ Full\ Screen\ Mode key=<F5>
  "map <silent> <D-f> <Plug>PeepOpen

  "map <silent> <D-F> :call PeepMeAround()<CR>
  "map <silent> <D-F> :lcd %:h<cr>:pwd<cr><Plug>PeepOpen
  map <silent><leader>f <Plug>PeepOpen
  map <silent><leader>gf :lcd %:h<cr>:pwd<cr><Plug>PeepOpen

  macm Window.Select\ Previous\ Tab  key=<D-S-Left>
  macm Window.Select\ Next\ Tab	   key=<D-S-Right>
  map <silent> <D-{> :bp<CR>
  map <silent> <D-}> :bn<CR>
endif
