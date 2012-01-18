setlocal foldmethod=marker
setlocal spell spelllang=en_au
setlocal ai et sts=2 sw=2 tw=70 wrap formatoptions=tn
 
nnoremap Q gq}
 
" headings
nnoremap <leader>1 YpVr=o<ESC>
nnoremap <leader>2 YpVr-o<ESC>
nnoremap <leader>3 YpVr~o<ESC>
nnoremap <leader>4 YpVr^o<ESC>
nnoremap <leader>5 YpVr+o<ESC>
 
" title
iabbr i_version <c-r>='v1.0, '.strftime('%B %d, %Y')<CR>
iabbr i_name Barry Arthur
map <leader>t O<C-r>=expand('%:t')<cr><Esc>:s/\..*//<CR>:s/_/ /eg<CR>:s/\<\(\w\)/\U\1/g<CR><leader>1ii_name<c-]><CR>i_version<c-]><CR><CR>
 
" lists
function! MakeList(list_type)
  let lineno = line(".")
  call setline(lineno, a:list_type . " " . getline(lineno))
endfunction
map <leader>lb :call MakeList('*')<CR>j
map <leader>ln :call MakeList('.')<CR>j
 
syn match asciidocListBullet /^\s*[-*+]\+\s/
 
" allow multi-depth list chars (--, ---, ----, .., ..., ...., etc)
set formatlistpat=^\\s*\\(\\(\\d\\+\\.\\?\\)\\\|\\([.*-]\\+\\)\\)\\s\\+
