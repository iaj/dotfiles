" add german umlauts to words
setlocal isk+=ä,ü,ö,Ä,Ö,Ü

" map ,t to compile tex documents
map <buffer> <leader>t :!pdflatex -output-directory "%:h" "%" && rm "%:h/%:t:r.aux" && rm "%:h/%:t:r.log"<CR>

" open the file in the corresponding application
map <buffer> <leader>p :!open "%:r.pdf"<CR>
" map <leader>T :!rubber -d --inplace "%"<CR>
"10:55:30   Axioplase_: iaj: hum. :exe ":autocmd BufDelete foo bar" . g:firefox . "to activate qux"
