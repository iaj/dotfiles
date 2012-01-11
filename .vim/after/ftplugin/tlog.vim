set autochdir
function! OpenImageInLine() " {{{
    let l:picpath = expand('%:h') . "/" . matchstr(getline("."), 'pics\S*')
    " echom l:picpath
    if l:picpath != ""
    "     " exec "silent !open \"" . l:picpath . "\""
        " exec "silent !qlmanage -p \"" . l:picpath . "\""
        exec "!qlmanage -p ". l:picpath . " >& /dev/null"
    else
        echo "No picpath found in line."
    endif
endfunction
nmap <silent> <F2> :call OpenImageInLine()<CR>