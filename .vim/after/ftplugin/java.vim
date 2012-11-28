" Java-related plugin settings
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
" set fdl=1
" see below :D
" setlocal cinoptions+=(4j1

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
" Enable java function folding with \f
nnoremap \fo VaBzf

" Quick compile/run functions
function! CompileJava()
    write
    setlocal makeprg=javac\ -cp\ \"%:p:h\"\ %\ $*
    make
endfunction
" nmap <buffer> <F3> :call CompileJava()<CR>
map <buffer><leader>t :Java<CR>

function! RunClass()
    if !exists("b:class")
        let b:class = expand("%:t:r")
    endif
    execute '!java -cp "%:p:h" ' . b:class
endfunction
" nmap <buffer> <F4> :call RunClass()<CR>

function! InsertMainClass()
    exe "put='public class ".expand('%:t:r')."{'"
    put='public static void Main(String args()){'
    put='}'
    put='}'
    normal gg=G2jo
endfunction
command! InsertMain call InsertMainClass()<CR>

" autocmd Filetype java if expand('%:p') =~ expand('~/Documents/workspace/AnimalScript2/')|map <silent> <buffer> <F9> :!/opt/local/bin/ctags -R --links=yes --java-types=cimp -f ~/Documents/workspace/tags ~/Documents/workspace<CR>:!echo 'tags generated!'<CR>|endif
" make c-] work as f3 in eclipse
"autocmd Filetype java noremap <buffer> <C-]> :JavaSearchContext<cr>|set fdl=1|set fdm=manual
" autocmd Filetype java map <buffer> <F3> :execute 'NERDTree ' . expand('%:p:h')<CR>
"autocmd Filetype java noremap <buffer> <C-]> :JavaSearchContext<cr>|set fdl=1
" inoremap <C-Space> <C-X><C-U>
" inoremap for commandline vim
"autocmd BufWinEnter *.java silent loadview
"autocmd BufWinLeave *.java mkview

inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs><space><space><space><space>
" command! -buffer SetJavaCompiler call Exec('setlocal aw','setlocal makeprg=javac','map <lt>F2> :make %<CR>','map <lt>F3> :!java '.expand('%:r').'<CR>')
" command! -buffer SetJikesCompiler call Exec('setlocal aw','setlocal makeprg=jikes','map <lt>F2> :make %<CR>','map <lt>F3> :!java '.expand('%:r').'<CR>')
" command! SetEFMToJAva :set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#<CR>

function! MyControlSpace()
    " setzen des b:complType damit man einsehen kann, ob keyword oder
    " omnicompl
    let b:complType=0
    " TODO: abfrage ob java oder andere rat files <C-X><C-O>
    " if (&filetype == 'java')
    return "\<C-X>\<C-U>"
    " else
        " return "\<C-X>\<C-O>"
    " endif
endfunction
inoremap <C-Space> <c-r>=MyControlSpace()<CR>
inoremap <C-@> <c-r>=MyControlSpace()<CR>
inoremap <C-@> <C-X><C-U>

if expand('%:p') =~ expand('~/Documents/workspace/AnimalScript2/')|map <silent> <buffer> <F9> :!/opt/local/bin/ctags -R --links=yes --java-types=cimp -f ~/Documents/workspace/tags ~/Documents/workspace<CR>:!echo 'tags generated!'<CR>|endif
"
" Try to use eclim's <C-]> instead of the tags-buitlin one - will I regret
" noremap <buffer> <C-]> :JavaSearchContext<cr>|set fdl=1|set fdm=manual
" set fdl=1
set fdm=manual
setlocal cinoptions+=(4j1
" noremap <buffer> <C-]> :JavaSearchContext<cr>|set fdl=1
" inoremap <C-Space> let b:complType=0<CR>:execute ":normal \<C-X>\<C-U>"
"autocmd BufWinEnter *.java silent loadview
"autocmd BufWinLeave *.java mkview
" Eclim Settings

" _i imports whatever is needed for current line
nnoremap <silent> _i :JavaImport<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> _jd :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> <Leader><cr> :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> _jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> _jc :JavaCorrect<cr>
nnoremap <silent> _jm :JavaImportMissing<CR>
" ,i imports whatever is needed for current line
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> <F3> :JavaDocSearch -x declarations<cr>
" quick editing of testfile in animalscript2
nnoremap <buffer><silent> \t :e /Users/iaj/Documents/workspace/AnimalScript2/Testsuite2/animal2test.asu<CR>
" map <C-[> :JavaSearchContext<CR>
" noremap \pl :ProjectList<CR>
" noremap \pc :ProjectClose
" noremap \po :ProjectOpen
" map <C-\> :e<CR>:exec("tag ".expand("<cword>"))<CR>
" set tags=./tags;$HOME
" for current word search for eclim
" nmap <f9> :exec 'vimgrep /\<'.expand(’<cword>’).'\>/g **/*.xml **/*.java'<CR>
" for vimgrep next and previous result
" Insert closing bracket after {<CR>
inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs><space><space><space><space>

command! JGS :JavaGetSet|:!normal gg=G
"com! Tags '/Users/iaj/bin/ctags -R --language-force=java -f.tags /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Classes'

" bachelor arbeit specific
"com! Tags '/Users/iaj/bin/ctags -R --language-force=java ~/Documents/workspace'
" bachelor arbeit - alle tags neusetzen projektspezifisch - für Animal als
" auch AnimalScript2
fun! MyTest() "{{{
    let foo = call JavaSearchContext()<CR>
endfunction "}}}


" Specific highlighting
highlight link CTagsClass Special
highlight link CTagsField PreProc

set shiftwidth=2
