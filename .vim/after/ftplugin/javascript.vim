set omnifunc=javascriptcomplete#CompleteJS
" Google's JSLint
"au BufRead *.js set makeprg=jslint\ %
set makeprg=gjslint\ %
set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G
syn keyword javascriptIdentifier "let"

setlocal define=^\\s*\\(function\\\|var\\\|define\\)[('\"]\\{-\\}
setlocal suffixesadd+=.js
" setlocal include=^\\s\\{,2}['\"]\\zs[^'\"]*\\ze
let &l:include = '^\s\{,' . (&shiftwidth * 2) . "}['\\\"]\\zs[^'\\\"]*\\ze"

" matchit
let b:match_words = '\<function\>:\<return\>,'
  \ . '\<do\>:\<while\>,'
  \ . '\<switch\>:\<case\>:\<default\>,'
  \ . '\<if\>:\<else\>,'
  \ . '\<try\>:\<catch\>:\<finally\>'

" banner
nnoremap <buffer> ,g I// <Esc>A //<Esc>yyp0llv$hhhr-yykPjj

" tag jumps
nnoremap <buffer> <C-]> :Bombit<CR>:tjump /<c-r>=expand('<cword>')<CR><CR>
nnoremap <buffer> <C-}> :Bombit<CR>:ptjump /<c-r>=expand('<cword>')<CR><CR>

" quick moves
nnoremap <silent> <buffer> ]] :call functions#CustomJump('/\v^\s*(function\|var)')<cr>
nnoremap <silent> <buffer> [[ :call functions#CustomJump('?\v^\s*(function\|var)')<cr>

" block un/comment
xnoremap <buffer> ?? <Esc>'<yyP"_C/*<Esc>'>yyp"_C*/<Esc>
xnoremap <buffer> !! <Esc>'<"_dd'>"_dd'<

" select function
xnoremap <buffer> af :<C-u>call javascript#SelectFunction()<CR>
onoremap <buffer> af :normal vaf<CR>

" generate event handler
nnoremap <buffer> ,h yiw}o<C-r><C-u>function <C-r>"(event){<CR>};<C-o>O

nnoremap <buffer> ,l yiwoconsole.log("<C-r>"", <C-r>");<Esc>
xnoremap <buffer> ,l yoconsole.log("<C-r>"",<C-r>");<Esc>

nnoremap <buffer> ,q ciw"<C-r>"", <C-r>"<Esc>
xnoremap <buffer> ,q c"<C-r>"", <C-r>"<Esc>

" reformat selection
command! -buffer -range=% Format let b:winview = winsaveview() |
  \ execute <line1> . "," . <line2> . "!js-beautify -f - -j -B -s " . &shiftwidth |
  \ call winrestview(b:winview)

" poor man's syntastic ;-)
setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
setlocal makeprg=jshint
command! -buffer Make silent make % | silent redraw! | silent wincmd p
autocmd! BufWritePost <buffer> Make
