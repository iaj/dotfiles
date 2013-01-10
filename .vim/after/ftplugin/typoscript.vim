" Special indent-function
function! TypoScriptIndent()
    let previous = getline(v:lnum-1)
    let current = getline(v:lnum)

    if previous =~ '[{(]$'
        return indent(v:lnum) + &sw 
    elseif current =~ '[})]$'
        return indent(v:lnum) - &sw
    else
        return -1
    endif
endfunction
set indentexpr=TypoScriptIndent()

set indentkeys+=(,)

" Automatically close brackets {, and (
inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs>
inoremap <buffer> (<cr> ()<left><cr>.<cr><esc>kA<bs>

setlocal commentstring=#%s
