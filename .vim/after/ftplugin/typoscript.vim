function! TestIndent()
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
set indentexpr=TestIndent()

set indentkeys+=(,)
