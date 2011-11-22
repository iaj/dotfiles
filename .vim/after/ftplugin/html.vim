"setlocal makeprg=tidy\ -quiet\ -errors\ %
"setlocal makeprg=tidy\ -m\  %
"setlocal errorformat=line\ %l\ column\ %v\ -\ %m
"setlocal equalprg=tidy\ -quiet\ -m\ -utf8\ %
"setlocal makeprg=tidy\ -quiet\ -m\ -utf8\ %
"setlocal makeprg=tidy\ -utf8\ -indent\ -q\ -f\ /tmp/err
"setlocal equalprg=tidy\ -utf8\ -indent\ --show-body-only yes\ -q\ -f\ /tmp/err
setlocal makeprg=tidy\ -quiet\ -errors\ %
setlocal errorformat=line\ %l\ column\ %v\ -\ %m

" enable a shortcut for tidy using ~/.tidyrc config
"map <Leader>T :!tidy -config ~/.tidyrc<cr><cr>
"nnoremap <silent> <Leader>T :!tidy -utf8 -m --show-body-only yes %<CR>
"nnoremap <silent> <Leader>T :!tidy -utf8 -m -i %<CR>
" enable html tag folding with \t

" Make selecting inside an HTML tag less dumb
"nnoremap Vit vitVkoj
"nnoremap Vat vatV
