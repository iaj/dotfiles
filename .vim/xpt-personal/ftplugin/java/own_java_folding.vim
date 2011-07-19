"function! Num2S(num, len)
    "let filler = "                                                            "
    "let text = '' . a:num
    "return strpart(filler, 1, a:len - strlen(text)) . text
"endfunction

"function! FoldText()
    "let sub = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=', '', 'g')
    "let diff = v:foldend - v:foldstart + 1
    "return  '+' . v:folddashes . '[' . Num2S(diff,3) . ']' . sub
"endfunction
"setlocal foldtext=FoldText()
"setlocal fdm=manual

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()
