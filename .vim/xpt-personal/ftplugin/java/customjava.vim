" Custom Java settings

" java-related plugin settings
" support for java omnicomplete using javacomplete plugin
"setlocal omnifunc=javacomplete#Complete

" quick compile/run functions
nmap <buffer> <F3> :call CompileJava()<CR>

function! CompileJava()
    write

    setlocal makeprg=javac\ -cp\ \"%:p:h\"\ %\ $*
    make
endfunction

nmap <buffer> <F4> :call RunClass()<CR>

function! RunClass()
    if !exists("b:class")
        let b:class = expand("%:t:r")
    endif

    execute '!java -cp "%:p:h" ' . b:class
endfunction
" "compiler javac
" compiler javac
" setlocal aw
" 
" map <F2> :make %<CR>
" map <F3> :!java %:r<CR>
" 
" exec vl#lib#vimscript#dontloadtwice#DontLoadTwice('b:ftpjava')
" function! InsertMainClass()
"   exe "put='public class ".expand('%:t:r')."{'"
"   put='public static void Main(String args()){'
"   put='}'
"   put='}'
"   normal gg=G2jo
" endfunction
"
" 
" command! -buffer SetJavaCompiler call Exec('setlocal aw','setlocal makeprg=javac','map <lt>F2> :make %<CR>','map <lt>F3> :!java '.expand('%:r').'<CR>')
" command! -buffer SetJikesCompiler call Exec('setlocal aw','setlocal makeprg=jikes','map <lt>F2> :make %<CR>','map <lt>F3> :!java '.expand('%:r').'<CR>')
" "command :InsertMC call InsertMainClass()<CR>
" map \mc :call InsertMainClass()<CR>
" command! SetEFMToJAva :set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#<CR>
