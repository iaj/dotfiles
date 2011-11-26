" Author:  iaj (tyberion@googlemail.com)
"
" NOTE:
" If you're editing this in Vim and don't know how folding works, type zR to
" unfold everything.  And then read ":help folding".

" Skip this file unless we have +eval and Vim 7.0 or greater.  With an older
" Vim, I'd rather just plain ol' vi emulation reminding me to upgrade.

""" Settings

" Don't load csapprox if no gui support - silences an annoying warning
set t_Co=256
if !has("gui")
    let g:CSApprox_verbose_level = 0
endif
set nocompatible
set hidden

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
filetype plugin indent on

" Vim Addon Manager
fun SetupVAM()
    let addons_base = expand('$HOME') . '/vim-addons'
    exec 'set runtimepath+='.addons_base.'/vim-addon-manager'
    if !isdirectory(addons_base)
        exec '!p='.shellescape(addons_base).'; mkdir -p "$p" && cd "$p" && git clone git://github.com/MarcWeber/vim-addon-manager.git'
    endif
    call vam#ActivateAddons(['vim-comment-object', 'ctrlp', 'markdown', 'matchit.zip', 'surround', 'tComment', 'fugitive', 'xptemplate', 'netrw', 'taglist', 'ZoomWin', 'cocoa', 'sparkup', 'lodgeit', 'Solarized', 'vim-markdown-preview' ], {'auto_install' : 2})
endf
call SetupVAM()

" set lazyredraw                         " Avoid redrawing the screen mid-command.
set undolevels=1000
set encoding=utf-8
let mapleader = ","
let maplocalleader = "\\"
set antialias
set guifont=Monaco:h12.00
"set guifont=Inconsolata-g:h14
set title
set isfname-=\=
"set macmeta
"set iskeyword+=äöüÄÖÜ
"
set switchbuf=useopen
" set numberwidth=5

" Always show tab bar
set showtabline=2
" set winwidth=84

" Don't highlight more than 200 columns as I normally don't have that long
" lines and they slow down syntax coloring. Thanks to Derek Wyatt
" (http://www.derekwyatt.org/vim/the-vimrc-file/).
if has('syntax')
    set synmaxcol=200
    " Highlight lines longer than 85 characters. Thanks to Tony Mechelynck
    " <antoine.mechelynck@gmail.com> from the Vim mailing list. It can easily be
    " disabled when necessary with :2match (in Vim >= 700).
    "if v:version >= 700
    "2match Todo /\%>85v./
    "else
    "match Todo /\%>85v./
    "endif
    " Highlight TODO, FIXME, CHANGED and XXX in all documents.
    if v:version > 701 || (v:version == 701 && has('patch42'))
        call matchadd('Todo', '\(TODO\|FIXME\|CHANGED\|XXX\)')
    endif
endif

""" Sourcing ~/.vimrc and own scripts
source $HOME/.vim/personal/scripts/remappings
source $HOME/.vim/personal/scripts/mappings
source $HOME/.vim/personal/scripts/functions
source $HOME/.vim/personal/scripts/autocommands
source $HOME/.vim/personal/scripts/galal
source $HOME/.vim/personal/scripts/objctagjump
"source $HOME/.vim/personal/scripts/error_handling

" Add xptemplate global personal directory value
if has("unix")
    set runtimepath+=~/.vim/xpt-personal
endif

"  Titlebar string: hostname> ${PWD:s/^$HOME/~} || (view|vim) filename ([+]|)
let &titlestring  = hostname() . '> ' . '%{expand("%:p:~:h")}'
            \ . ' || %{&ft=~"^man"?"man":&ro?"view":"vim"} %f %m'
set nocursorcolumn
set magic
set cursorline

" Files that should be ignored by default - in completition as well as in Command-T
set wildignore=.backup,.dropbox,.gem,.cheat,.DS_Store,.fontconfig,.hamachi,.class,.o,.toc,.obj
set wildignore+=
    \*.png,*.jp*g,*.pdf,*.bmp,
    \*/.git/*,*/.hg/*,*/.svn/*,
    \CVS,SVN,
    \*/undo/*,
    \*/typo3temp/*,*/uploads/*,*/t3lib/*,*/typo3/*,*/typo3_src*/*

" Moving Around/Editing
set whichwrap=b,s,h,l,<,>       " <BS> <Space> h l <Left> <Right> can change lines
set virtualedit=block           " Let cursor move past the last char in <C-v> mode
set scrolloff=8                 " Keep 3 context lines above and below the cursor
set backspace=indent,eol,start

set showmatch                   " Briefly jump to a paren once it's balanced
set matchtime=2                 " (for only .2 seconds).
set matchtime=123

" Searching and Patterns
set ignorecase                  " Default to using case insensitive searches,
set smartcase                   " unless uppercase letters are used in the regex.
set hlsearch                    " Highlight searches by default.
set incsearch                   " Incrementally search while typing a /regex

" Windows, Buffers
set noequalalways               " Don't keep resizing all windows to the ~/.vimrc
set hidden                      " Hide modified buffers when they are abandoned
set swb=useopen,usetab          " Allow changing tabs/windows for quickfix/:sb/etc
set splitright                  " New windows open to the right of the current one

set matchpairs+=<:>             " show matching <> (html mainly) as well

" Insert completion
"set completeopt-=preview        " Don't show preview menu for tags.
set completeopt=longest,menuone
set complete=.,w,b,t
"set infercase                   " Try to adjust insert completions for case.

" Folding
set foldmethod=syntax           " By default, use syntax to determine folds
set foldlevelstart=99           " All folds open by default
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Text Formatting
set formatoptions=q             " Format text with gq, but don't format as I type.
set formatoptions+=n            " gq recognizes numbered lists, and will try to
set formatoptions+=r            " break before, not after, a 1 letter word
set formatoptions+=1            " break before, not after, a 1 letter word
"sjl: set formatoptions=qrn1

" Display
if (v:version == 703) 
    set relativenumber
    set undofile
    set undodir=~/.vim/undo
else
    set number
endif

" set numberwidth=1               " using only 1 column (and 1 space) while possible
set nowrap

if &enc =~ '^u\(tf\|cs\)' " When running in a Unicode environment,
    set list                    " visually represent certain invisible characters:
    let s:arr = nr2char(9655) " using U+25B7 (▷) for an arrow, and
    let s:dot = nr2char(8901) " using U+22C5 (⋅) for a very light dot,
    " display tabs as an arrow followed by some dots (▷⋅⋅⋅⋅⋅⋅⋅),
    exe "set listchars=tab:" . s:arr . s:dot
    " and display trailing and non-breaking spaces as U+22C5 (⋅).
    exe "set listchars+=trail:" . s:dot
    exe "set listchars+=nbsp:"  . s:dot
    " Also show an arrow+space (↪ ) at the beginning of any wrapped long lines?
    " I don't like this, but I probably would if I didn't use line numbers.
    let &sbr=nr2char(8618).' '
    " set listchars+=eol:¬
endif

set confirm                     " Y-N-C prompt if closing with unsaved changes.
set cmdheight=2                 " Prevent "Press Enter" message after most commands
set showcmd                     " Show incomplete normal mode commands as I type.
set report=0                    " :commands always print changed line count.
set shortmess+=a                " Use [+]/[RO]/[w] for modified/readonly/written.
set shortmess+=A                " Don't show message on existing swapfile
set ruler                       " Show some info, even without statuslines.
set autoindent

"typoscript indent fix?
set cink-=0#
set cino=(0                     " line up sublines with first (
"set cindent
"set smartindent
set notimeout ttimeout ttimeoutlen=200

" Tabs/Indent Levels
set tabstop=8                   " keep tabspaces at 8 by default if there
set shiftwidth=4                " shiftwidth ~ indentaion to the right
set softtabstop=4               " indendation to the left (bs key)
set expandtab                   " Use spaces, not tabs, for autoindent/tab key.
set smarttab
"set noexpandtab
set mousehide
set mousem=popup

"Print options
set printoptions+=syntax:n      " Print syntax highlighting.
set printoptions+=header:0      " Don't print that annoying file info
"set printoptions+=number:y     " Print line numbers.

" Tags
set tags=./tags;$HOME
"set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,/Users/tags
set showfulltag                 " Show more information while completing tags.

" Reading/Writing
set noautowrite                 " Never write a file unless I request it.
set noautowriteall              " NEVER.
set noautoread                  " Don't automatically re-read changed files.
set modeline                    " Allow vim options to be embedded in files;
set modelines=5                 " they must be within the first or last 5 lines.
set ffs=unix,dos,mac            " Try recognizing dos, unix, and mac line endings.

" Backups/Swap Files
" Make sure that the directory where we want to put swap/backup files exists.
if ! len(glob("~/.backup/"))
    echomsg "Backup directory ~/.backup doesn't exist!"
endif
set history=10000
set writebackup                 " Make a backup of the original file when writing
set backup                      " and don't delete it after a succesful write.
set backupskip=                 " There are no files that shouldn't be backed up.
set backupdir^=~/.backup        " Backups are written to ~/.backup/ if possible.
set directory^=~/.backup        " Swap files are also written to ~/.backup, too.
set updatetime=500              " Write swap files after 2 seconds of inactivity.
set backupext=~                 " Backup for "file" is "file~"

"""" Command Line
set wildmenu                    " Menu completion in command mode on <Tab>
set wildmode=list:longest,full

" GRB: use emacs-style tab completion when selecting files, etc
" set wildmode=longest,list
set wcm=<C-Z>                   " Ctrl-Z in a mapping acts like <Tab> on cmdline
"set timeoutlen=100

" Per-Filetype Scripts
" NOTE: These define autocmds, so they should come before any other autocmds.
"       That way, a later autocmd can override the result of one defined here.
set grepprg=grep\ -nH\ $*

""" Plugin Settings
"""" eclim settings
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'
" Determines what action to take when a only a single result is found.
" Possible values include:
" * ‘split’ - open the result in a new window via “split”.
" * ‘edit’ - open the result in the current window.
" * ‘tabnew’ - open the result in a new tab.
" * ‘lopen’ - open the location list to display the result.
let g:EclimJavaSearchSingleResult='edit'
" Let <CR> search for the single class/method directly
let g:EclimJavaSearchMapping = 1
" Disable HTML & PHP validation
let g:EclimHtmlValidate = 0
let g:EclimPhpValidate = 0
" ,i imports whatever is needed for current line
" nnoremap <silent> <LocalLeader>i :JavaImport<cr>
" ,d opens javadoc for statement in browser
" nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
" nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
" ,jv validates current java file
" nnoremap <silent> <LocalLeader>jv :Validate<cr>
" ,jc shows corrections for the current line of java
" nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>
" Disable Eclim's taglisttoo because I use the regular taglist plugin
"let g:taglisttoo_disabled = 1


"""" gundo - Graphical UNDO - pretty awesome imo
let g:gundo_width = 60
"let g:gundo_preview_height = 40
"let g:gundo_right = 1

"""" Taglist Settings (eg. show tags only for the current file)
let g:Tlist_Show_One_File = 1
"let Tlist_Max_Tag_Length = 200
let Tlist_WinWidth=50
let Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Ctags_Cmd = "~/bin/ctags" "user defined ctags command
let tlist_objc_settings = 'objc;i:interface;c:class;m:method;p:property'
let Tlist_Close_On_Select=1
let Tlist_Compact_Format=1
let Tlist_Use_Right_Window = 1

"""" XPTemplate Settings
let g:xptemplate_brace_complete = 0
let g:xptemplate_vars = "$author=iaj\ (tyberion@googlemail.com)&$email=tyberion@gmail.com&"
"let g:xptemplate_key = '<Tab>'
" let g:xptemplate_nav_next = '<C-j>'
" let g:xptemplate_nav_prev = '<C-k>'

"""" Sparkup Settings
let g:sparkupExecuteMapping = '<D-e>'

"""" Command-T Settings
let g:CommandTMaxHeight = 20
let g:CommandTMaxFiles=3000
let g:CommandTScanDotDirectories=1
"let g:CommandTCancelMap = ['<C-c>']
"let g:CommandTAlwaysShowDotFiles=1
"let g:CommandTMatchWindowAtTop=1

"""" netrw Settings
let g:netrw_altv          = 1
let g:netrw_fastbrowse    = 2
let g:netrw_keepdir       = 0
let g:netrw_liststyle     = 2
let g:netrw_retmap        = 1
let g:netrw_silent        = 1
let g:netrw_special_syntax= 1
if has("eval")
    let g:netrw_keepdir = 1                       " does not work!
    let g:netrw_list_hide = '.*\.swp\($\|\t\),.*\.py[co]\($\|\t\)'
    let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$,\.py[co]$'
    let g:netrw_timefmt = '%Y-%m-%d %H:%M:%S'
    let g:netrw_use_noswf = 1
endif

"""" FuzzyFinder Settings
let g:returning_from_fuzzy = 0
let g:fuf_modesDisable = [ 'mrucmd' ]
let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[po]|mail|sparrow)$|^(\/\/|\\\\|\/mnt\/|\/media\/|\/var\/folders\/)'
let g:fuf_mrufile_maxItem = 300
"let g:fuf_mrucmd_maxItem = 400

"""" ctrlp settings
let g:ctrlp_working_path_mode = 2
let g:ctrlp_mruf_max = 300
let g:ctrlp_match_window_reversed = 0
" let g:ctrlp_match_window_bottom = 0
let g:ctrlp_prompt_mappings = {
            \ 'PrtDelete()':          ['<c-h>']
            \ }

""" Dimensions for MacVim + Colorscheme
if has('gui_running')
    "set columns=153
    :set guioptions=Aci
    :set lines=100
    :set columns=200
    :set fuoptions=maxvert,maxhorz

    " set go-=T
    " Don't show scroll bars in the GUI
    :set guioptions-=L
    :set guioptions-=r

    let g:molokai_original = 1 " lighter background in gVim
    :let g:zenburn_high_Contrast = 1 " darker colors
    :set background=dark
    " set background=light
    colorscheme solarized
    " :hi Normal guib=#252626
    " :colorscheme molokai_jay
    " :colorscheme sjl
    " :colorscheme grb256
    " :colo tir_black
    " hi VisualNOS guibg=#444444
    " hi Visual guibg=#424242
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    hi TabLine guifg=#85816E guibg=#20211B gui=none
    hi TabLineFill guifg=#85816E guibg=#171812 gui=none
    hi TabLineSel guifg=#A6E22E guibg=#3B3A32 gui=none
else
    set background=dark
    colorscheme solarized
    " :colorscheme ir_black
    " colorscheme molokai_kien
    "colorscheme molokai           "one hell of a amazing great-magenta colorscheme
endif

""" Statusline
set ls=2
if has('statusline') && has('gui_running')
    if g:colors_name=='lucius' || g:colors_name=='vitamins' || g:colors_name=='ir_black' || g:colors_name=='grb' || g:colors_name=='vincent' || g:colors_name=='mustang' || g:colors_name=='herald' || g:colors_name=='CloudsMidnight' || g:colors_name == 'tir_black'
                \|| g:colors_name=='grb256'
        let fg_bg = 2
    else
        let fg_bg = 1
    endif
    " Function used to display syntax group.
    function! SyntaxItem()
        return synIDattr(synID(line("."),col("."),1),"name")
    endfunction 
    "set statusline=......%{FileSize()}.....
    function! BA_StatusLine()
        if expand('%:p') =~ expand('~/Documents/workspace/AnimalScript2/')
            return "[AnimalScript2] "
        elseif expand('%:p') =~ expand('~/Documents/workspace/Animal/')
            return "[Animal] "
        else
            return ""
        endif
    endfunction

    "on some colorschemes (kw: reversing) its necessary to s/fg/bg
    fun! UpdateStatuslineColorCodes() "{{{
        " themes differ here - replace bg with fg or the other way around ;)
        if (g:fg_bg == 1)
            let g:status_active_bg=synIDattr(synIDtrans(hlID("StatusLine")), "fg")
            let g:status_inactive_bg=synIDattr(synIDtrans(hlID("StatusLineNC")), "fg") 
        else
            let g:status_active_bg=synIDattr(synIDtrans(hlID("StatusLine")), "bg")
            let g:status_inactive_bg=synIDattr(synIDtrans(hlID("StatusLineNC")), "bg") 
        endif
    endfunction "}}}
    function! SetMyStatusLine()
        " TODO fix that stuff
        if (!has('gui_running'))
            return
        endif
        call UpdateStatuslineColorCodes()
        " First of all, my USER defined Colors
        "buffnum
        exec 'hi User1 guifg=#A6E22E guibg=' . g:status_active_bg
        "filetype      (currently magenta - too bright = not used)
        exec 'hi User2 guifg=#66D9EF guibg=' . g:status_active_bg
        "highlighting group
        exec 'hi User3 guifg=orange guibg=' . g:status_active_bg
        "git
        exec 'hi User4 guifg=green guibg=' . g:status_active_bg
        "magenta
        exec 'hi User9 guifg=#F92672 guibg=' . g:status_active_bg
        "exec 'hi User4 guifg=#F92672 guibg=' . g:status_active_bg
        "hi link User5 StatusLineNC
        " INAKTIVE STATUSBARSETTING
        exec 'hi User5 guifg=#111111 guibg=' . g:status_inactive_bg
        exec 'hi User6 guifg=#111111 guibg=' . g:status_inactive_bg
        exec 'hi User7 guifg=#111111 guibg=' . g:status_inactive_bg
        exec 'hi User8 guifg=#111111 guibg=' . g:status_inactive_bg
        exec 'hi User10 guifg=#111111 guibg=' . g:status_inactive_bg

        "if (&stl =~ 'SyntaxItem')
        if (1 == 1) "crazed uh?
            " Here comes the status line
            set laststatus=2                                                    " Always show status.
            "sjl set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
            set statusline=%1*%-2.2n%*                                          " Buffer number.
            set statusline+=\ %f                                                " Filename.%F  orig:%t
            set statusline+=\ (%9*%{strlen(&ft)?&ft:'none'}%*::
            "set statusline+=\ (%9*%{(&ft==\"\"?&"":&ft)}%*)                    " Encoding.
            set statusline+=\%2*%{(&fenc==\"\"?&enc:&fenc)}%*)                  " Encoding.
            set statusline+=%(\ [%4*%H%R%M%*]%)                                 " Flags.

            "set statusline+=\ %{exists('actual_curbuf')&&bufnr('%%')==actual_curbuf?CountMatches(1):''}
            set statusline+=%=                                                  " Left-right alignment.

            " syntastic error in statusline
            " set statusline+=%#warningmsg#
            " set statusline+=%{SyntasticStatuslineFlag()}
            " set statusline+=%*

            set statusline+=\ %(%3*%{SyntaxItem()}%*%)                          " Highlighting group.
            set statusline+=\ %-14.(%l/%L,%v%)                                  " Line/column number.
            set statusline+=\ %P                                                " % through file.
            set statusline+=\ %4*%{fugitive#statusline()}%*

            "" This trick is so I can better control the colors of the non-current
            "" statusline. By default it flips the bold attribute flag in all cases,
            "" which I don't like. See the %* field in :help 'statusline'
            "%5*%-2.2n%* %t (%10*%{strlen(&ft)?&ft:'none'}%*::%6*%{(&fenc==""?&enc:&fenc)}%*)%( [%8*%H%R%M%*]%)%=%(%7*%{SyntaxItem()}%*%) %-14.(%l/%L,%v%) %P %8*%{fugitive#statusline()}%*
            let g:c_statusline = &g:statusline
            " Quadro Substitution in a strange manner
            let g:nc_statusline =
                        \ substitute(
                        \ substitute(
                        \ substitute(
                        \ substitute(
                        \ substitute(g:c_statusline, '%1', '%5', 'g'),
                        \ '%2', '%6', 'g'),
                        \ '%3', '%7', 'g'),
                        \ '%4', '%8', 'g'),
                        \ '%9', '%8', 'g')
        else
            let g:c_statusline="%1*%-2.2n%* %t (%9*%{strlen(&ft)?&ft:'none'}%*::%2*%{(&fenc==""?&enc:&fenc)}%*)%( [%4*%H%R%M%*]%)%= %-14.(%l/%L,%v%) %P %4*%{fugitive#statusline()}%*"
            let g:nc_statusline="%5*%-2.2n%* %t (%8*%{strlen(&ft)?&ft:'none'}%*::%6*%{(&fenc==""?&enc:&fenc)}%*)%( [%8*%H%R%M%*]%)%= %-14.(%l/%L,%v%) %P %8*%{fugitive#statusline()}%*"
            "set statusline="%1*%-2.2n%* %t (%2*%{(&fenc==""?&enc:&fenc)}%*)%( [%4*%H%R%M%*]%)%=%(%3*%{SyntaxItem()}%*%) %-14.(/,%v%) %4*%{fugitive#statusline()}%*%{XPMautoUpdate("statusline")}"
        endif
    endfunction
    nmap <silent> \ds :call SetMyStatusLine()<CR>
    au VimEnter * call UpdateStatuslineColorCodes()
    au VimEnter * call SetMyStatusLine()
    " Window title
    if has('title')
        "set titlestring=%f%(\ [%R%M]%)
        let &titlestring=expand("%:p:h")
        let &titlestring=$PWD
    endif
else
    " GRB: Put useful info in status line
    " green
    hi User1 guifg=green guibg=#363946 ctermfg=green ctermbg=237 gui=bold guifg=#e0e0e0 guibg=#363946
    " magenta
    hi User2 term=bold cterm=bold ctermfg=161 gui=bold guifg=#F92672 guibg=#363946 ctermbg=237
    " cyan
    hi User3 term=bold cterm=bold ctermfg=81 gui=bold guifg=#66d9ef guibg=#363946 ctermbg=237
    "set statusline=%<%f\ (%2*%{&ft}%*)\ %-4(%m%)%=%-19(%3l,%02c%03V%)%P\ %1*%{fugitive#statusline()}%*"
    set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)%P\ %{fugitive#statusline()}%*"
endif

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! MyTabComplete()
    " complType=1 = invoked by keyword from buffers matching only
    if pumvisible()
        " keyword completion - invokes a 1
        if (b:complType==1)
            return "\<C-P>"
        else
            " else just crawl normally
            return "\<C-N>"
        endif
    endif

    let b:complType=0
    "let line = getline('.')                         " curline
    "let substr = strpart(line, -1, col('.')+1)      " from start to cursor
    "let substr = matchstr(substr, "[^ \t]*$")       " word till cursor

    " locate the start of the word
    let line = getline('.')
    let col = col('.')
    let current = col - 1

    while current > 0 && line[current - 1] =~ '\S'
        let current -= 1
    endwhile
    "return substr

    " debugging...
    "echom 'Indexes: '.current.':'.col
    let substr = substitute(line[(current-1):(col-2)], '^\s*', '', '')
    "echom 'Substring before the cursor: '.string(substr)

    "echom 'current: '.current.', '.'line: '.string(line[: current - 1])
    if col == 1 || substr =~ '^\s*$'
        return "\<tab>"
    endif

    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any

    "if (&dictionary != '' && !has_slash)
    "return "\<C-X>\<C-K>"
    "endif
    "if (&filetype == 'objc')
    "return "\<C-X>\<C-O>"
    "endif
    if (!has_period && !has_slash)
        let b:complType=1
        return "\<C-P>"                             " existing text matching
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                       " file matching
    else " we got a period somewhere in here...
        if (&filetype == 'java')
            return "\<C-P>"
            "return "\<C-X>\<C-U>"                   " ECLIM completion
            "elseif (&omnifunc != '')
            "return "\<C-X>\<C-O>"                  " plugin matching
        else
            let b:complType=1
            return "\<C-P>"
        endif
    endif
endfunction

function! MyShiftTabComplete()
    if (pumvisible() && b:complType==1)
        return "\<C-N>"
    else
        return "\<C-P>"
    endif
endfunction
inoremap <tab> <c-r>=MyTabComplete()<cr>
inoremap <s-tab> <c-r>=MyShiftTabComplete()<cr>
"" vim:fdm=expr
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
