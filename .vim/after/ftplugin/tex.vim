setlocal isk+=ä,ü,ö,Ä,Ö,Ü
map <buffer> <leader>t :!pdflatex -output-directory "%:h" "%" && rm "%:h/%:t:r.aux" && rm "%:h/%:t:r.log"<CR>
map <buffer> <leader>p :!open "%:r.pdf"<CR>
" map <leader>T :!rubber -d --inplace "%"<CR>
"10:55:30   Axioplase_: iaj: hum. :exe ":autocmd BufDelete foo bar" . g:firefox . "to activate qux lol kthxbye"
