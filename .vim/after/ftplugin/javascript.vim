set omnifunc=javascriptcomplete#CompleteJS
" Google's JSLint
"au BufRead *.js set makeprg=jslint\ %
set makeprg=gjslint\ %
set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G
syn keyword javascriptIdentifier "let"
