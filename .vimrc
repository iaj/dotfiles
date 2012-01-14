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
    if has('gui_running')
        call vam#ActivateAddons(['powerline', 'repeat', 'ack', 'vim-comment-object', 'ctrlp', 'markdown', 'matchit.zip', 'surround', 'tComment', 'fugitive', 'xptemplate', 'netrw', 'taglist', 'ZoomWin', 'sparkup', 'lodgeit', 'Solarized', 'vim-markdown-preview', 'cocoa' ], {'auto_install' : 2})
    else
        call vam#ActivateAddons(['ack', 'repeat', 'vim-comment-object', 'ctrlp', 'markdown', 'matchit.zip', 'surround', 'tComment', 'fugitive', 'xptemplate', 'netrw', 'taglist', 'ZoomWin', 'sparkup', 'lodgeit', 'Solarized', 'vim-markdown-preview', 'cocoa' ], {'auto_install' : 2})
    endif
endf
call SetupVAM()

set lazyredraw                         " Avoid redrawing the screen mid-command.
set undolevels=1000
set encoding=utf-8
let mapleader = ","
let maplocalleader = "\\"
set antialias
set guifont=Monaco:h12.00
" set guifont=Menlo\ Regular\ for\ Powerline:h12
" set guifont=Inconsolata-g:h14
" set guifont=Mensch\ for\ Powerline:h12
set title
set isfname-=\=
"set macmeta
"set iskeyword+=äöüÄÖÜ
set ls=2

set switchbuf=useopen
" set numberwidth=5

" Always show tab bar
set showtabline=2
" set winwidth=84

" Don't highlight more than 200 columns as I normally don't have that long
" lines and they slow down syntax coloring. Thanks to Derek Wyatt
" (http://www.derekwyatt.org/vim/the-vimrc-file/).
if has('syntax')
    set synmaxcol=0
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
" source $HOME/.vim/personal/scripts/remappings
source $HOME/.vim/personal/scripts/mappings
source $HOME/.vim/personal/scripts/functions
source $HOME/.vim/personal/scripts/autocommands
source $HOME/.vim/personal/scripts/galal
source $HOME/.vim/personal/scripts/objctagjump
" au VimEnter * source $HOME/.vim/personal/scripts/statusline
"TODO fix those bars and have them run in your develop-environment
"source $HOME/.vim/personal/scripts/error_handling

" Add XPtemplate global personal directory value
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
    \*/.git/*,*/.hg/*,*/.svn/*,
    \CVS,SVN,
    \*/undo/*,
    \*/typo3temp/*,*/uploads/*,*/t3lib/*,*/typo3/*,*/typo3_src*/*
    " \*.png,*.jp*g,*.pdf,*.bmp,

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
    " and display trailing and non-breaking spaces as U+22C5 (⋅).
    " removed on 12/01/2011
    exe "set listchars=tab:" . s:arr . s:dot
    exe "set listchars+=trail:" . s:dot
    exe "set listchars+=nbsp:"  . s:dot
    " Also show an arrow+space (↪ ) at the beginning of any wrapped long lines?
    " I don't like this, but I probably would if I didn't use line numbers.
    let &sbr=nr2char(8618).' '
    " set listchars+=eol:¬
endif
set listchars+=extends:❯,precedes:❮
set fillchars=diff:⣿

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
" set wcm=<C-Z>                   " Ctrl-Z in a mapping acts like <Tab> on cmdline
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
" let g:xptemplate_key = '<Tab>'
let g:xptemplate_nav_next = '<C-j>'
let g:xptemplate_nav_prev = '<C-k>'

"""" Sparkup Settings
" let g:sparkupExecuteMapping = '<D-e>'

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

"""" Ctrl-P Settings
let g:ctrlp_working_path_mode = 2
let g:ctrlp_mruf_max = 2000
let g:ctrlp_match_window_reversed = 0
" let g:ctrlp_match_window_bottom = 0
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
            \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
            \ 'PrtDelete()':          ['<c-h>'],
            \ 'PrtHistory(-1)':       ['<c-n>'],
            \ 'PrtHistory(1)':        ['<c-p>'],
            \ 'ToggleFocus()':        ['<c-tab>'],
            \ }
let g:ctrlp_extensions = ['tag']
" let g:ctrlp_mruf_exclude = '\v\~$|\.(bak|sw[po]|mail|sparrow)$|^(\/\/|\\\\|\/mnt\/|\/media\/|\/var\/folders\/)'
let g:ctrlp_mruf_exclude = '*.xib\|/undo/*\|COMMIT_EDITMSG'
nnoremap <leader>. :CtrlPTag<cr>
map <silent> <leader>b :CtrlPBuffer<CR>
map <silent> <leader>r :CtrlPMRUFiles<CR>
map <silent> <leader>f :CtrlP<CR>
map <silent> <leader>gf :CtrlPCurFile<CR>
map <silent> <leader>F :ClearCtrlPCache<CR>
map <silent> <leader>gd :CtrlPCurWD<CR>
map <silent> \a :CtrlP 

"""" Powerline
let g:Powerline_symbols = 'fancy'

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
    " :colorscheme solarized
    " :hi Normal guib=#252626
    " :colorscheme vitamins
    :colorscheme mj
    " :colorscheme jellybeans
    " :colorscheme sjl
    " :colorscheme grb3
    " :colorscheme mustang
    " :colo tir_black
    " hi VisualNOS guibg=#444444
    " hi Visual guibg=#424242
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    hi TabLine guifg=#85816E guibg=#20211B gui=none
    hi TabLineFill guifg=#85816E guibg=#171812 gui=none
    hi TabLineSel guifg=#A6E22E guibg=#3B3A32 gui=none
else
    set background=dark
    :colorscheme solarized
    " :colorscheme molokai_jay
    " :colorscheme ir_black
    " :colorscheme molokai_kien
    " :colorscheme molokai           "one hell of a amazing great-magenta colorscheme
endif

""" my own Supertab
" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! MyTabComplete()
    " complType=1 = invoked by keyword from buffers matching only
    if pumvisible()
        " keyword completion - invokes a 1
        if (b:complType==1) || !exists(b:complType)
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
    let column = col('.')

    let current = column - 2  " fange beim zeichen eins links vom aktuellem an

    " echom 'aktuelles zeichen links vom cursor: '. line[current]

    while current > 0 && line[current] =~ '\S'
        let current -= 1
    endwhile

    " echom 'column des beginn des aktuellen wortes: '.current
    " echom 'aktuelle column(bis zu column): ' . column

    " debugging...
    "echom 'Indexes: '.current.':'.column
    let substr = substitute(line[(current):(column-2)], '^\s*', '', '')
    " let substr = substitute(line[(current-1):(column-2)], '^\s*', '', '')

    " echom 'substring: ' . substr
    " echom 'Substring before the cursor: '.string(substr)

    " echom 'current: '.current.', '.'line: '.string(line[: current - 1])
    if column == 1 || substr =~ '^\s*$'
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

""" Abbreviations
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

function! MakeSpacelessIabbrev(from, to)
    execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

call MakeSpacelessIabbrev('gh/',  'http://github.com/')

""" Statusline
if !(has('gui_running'))
    " GRB: Put useful info in status line
    hi User1 guifg=green guibg=#363946 ctermfg=green ctermbg=237 gui=bold guifg=#e0e0e0 guibg=#363946
    " magenta
    hi User2 term=bold cterm=bold ctermfg=161 gui=bold guifg=#F92672 guibg=#363946 ctermbg=237
    " cyan
    hi User3 term=bold cterm=bold ctermfg=81 gui=bold guifg=#66d9ef guibg=#363946 ctermbg=237
    "set statusline=%<%f\ (%2*%{&ft}%*)\ %-4(%m%)%=%-19(%3l,%02c%03V%)%P\ %1*%{fugitive#statusline()}%*"
    set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)%P\ %{fugitive#statusline()}%*"
endif
""" Error navigation
"
"             Location List     QuickFix Window
"            (e.g. Syntastic)     (e.g. Ack)
"            ----------------------------------
" Next      |     M-j               M-Down     |
" Previous  |     M-k                M-Up      |
"            ----------------------------------
nnoremap ∆ :lnext<cr>zvzz
nnoremap ˚ :lprevious<cr>zvzz
inoremap ∆ <esc>:lnext<cr>zvzz
inoremap ˚ <esc>:lprevious<cr>zvzz
nnoremap <m-Down> :cnext<cr>zvzz
nnoremap <m-Up> :cprevious<cr>zvzz
""" Mappings
"""" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc><right>
"""" Split/Join
"
" Basically this splits the current line into two new ones at the cursor position,
" then joins the second one with whatever comes next.
"
" Example:                      Cursor Here
"                                    |
"                                    V
" foo = ('hello', 'world', 'a', 'b', 'c',
"        'd', 'e')
"
"            becomes
"
" foo = ('hello', 'world', 'a', 'b',
"        'c', 'd', 'e')
"
" Especially useful for adding items in the middle of long lists/tuples in Python
" while maintaining a sane text width.
nnoremap K h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^
"" vim:fdm=expr
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
