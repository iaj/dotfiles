" Author:  iaj (tyberion@googlemail.com)
"
" NOTE:
" If you're editing this in Vim and don't know how folding works, type zR to
" unfold everything.  And then read ":help folding".
""" VAM
fun SetupVAM()
    let addons_base = expand('$HOME') . '/vim-addons'
    exec 'set runtimepath+='.addons_base.'/vim-addon-manager'
    if !isdirectory(addons_base)
        exec '!p='.shellescape(addons_base).'; mkdir -p "$p" && cd "$p" && git clone git://github.com/MarcWeber/vim-addon-manager.git'
    endif
    if has('gui_running')
        call vam#ActivateAddons(['powerline', 'fugitive', 'xptemplate', 'repeat', 'ack', 'vim-comment-object', 'ctrlp', 'matchit.zip', 'surround', 'tComment', 'netrw', 'taglist', 'ZoomWin', 'sparkup', 'lodgeit', 'Solarized', 'cocoa' ], {'auto_install' : 2})
    else
        " No Powerline on terminals please
        call vam#ActivateAddons(['fugitive', 'xptemplate', 'repeat', 'ack', 'vim-comment-object', 'ctrlp', 'matchit.zip', 'surround', 'tComment', 'netrw', 'taglist', 'ZoomWin', 'sparkup', 'lodgeit', 'Solarized', 'cocoa' ], {'auto_install' : 2})
    endif
endf
call SetupVAM()
""" Settings
" Don't load csapprox if no gui support - silences an annoying warning
set t_Co=256
if !has("gui")
    let g:CSApprox_verbose_level = 0
endif
set nocompatible
set hidden
" Don't want annoying movements
let macvim_skip_cmd_opt_movement = 1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
filetype plugin indent on

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
"set iskeyword+=äöüÄÖÜ
set ls=2

set switchbuf=useopen
" set numberwidth=5

" Always show tab bar
set showtabline=2
" set winwidth=84
set pastetoggle=<F11>

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
source $HOME/.vim/personal/scripts/functions
source $HOME/.vim/personal/scripts/autocommands
source $HOME/.vim/personal/scripts/galal
" au VimEnter * source $HOME/.vim/personal/scripts/statusline
" TODO fix those bars and have them run in your develop-environment
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
let g:vimsyn_folding = "af"
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
" let g:EclimDisabled='1'
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

"""" gundo - Graphical UNDO
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
nnoremap <silent> <F2> :TlistToggle<CR>

"""" XPTemplate Settings
" nnoremap <leader><space> :XPTreload<cr>
map ,X :he XPTemplate<CR>
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

"""" NetRW Settings
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
map <silent> \e :CtrlP 
"""" Powerline
let g:Powerline_symbols = 'fancy'
"""" Exhuberant ctags Settings
map <F9> :!/opt/local/bin/ctags --exclude=.svn --exclude=target -R .<CR>
map <Leader>ct :!/opt/local/bin/ctags --exclude=.svn --exclude=target -R .<CR>
"""" Ack Settings
" Search recursively in {directory} (which defaults to the current
" directory) for the {pattern}.  Behaves just like the |:grep| command, but
" will open the |Quickfix| window for you. If [!] is not given the first
" error is jumped to.
map <leader>a :Ack! 
"""" Fugitive
nmap \gs :Gstatus<cr>
nmap \gc :Gcommit<cr>
nmap \ga :Gwrite<cr>
nmap \gl :Glog<cr>
nmap \gd :Gdiff<cr>
"""" ZoomWin
" Map <C-w><C-O> to the same..
map <silent> <C-w><C-o> :ZoomWin<CR>
""" Colorscheme & dimensions for GUI
if has('gui_running')
    "set columns=153
    set guioptions=Aci
    set lines=100
    set columns=200
    set fuoptions=maxvert,maxhorz
    set macmeta

    " set go-=T
    " Don't show scroll bars in the GUI
    set guioptions-=L
    set guioptions-=r

    let g:molokai_original = 1 " lighter background in gVim
    let g:zenburn_high_Contrast = 1 " darker colors
    set background=dark
    " set background=light
    " colorscheme solarized
    " hi Normal guib=#252626
    " colorscheme vitamins
    " colorscheme jellybeans
    " colorscheme sjl
    " colo solarized
    colo mj
    " colorscheme grb3
    " colorscheme mustang
    " colo tir_black
    " hi VisualNOS guibg=#444444
    " hi Visual guibg=#424242
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    hi TabLine guifg=#85816E guibg=#20211B gui=none
    hi TabLineFill guifg=#85816E guibg=#171812 gui=none
    hi TabLineSel guifg=#A6E22E guibg=#3B3A32 gui=none
else
    set background=dark
    colorscheme solarized
    " :colorscheme molokai_jay
    " :colorscheme ir_black
    " :colorscheme molokai_kien
    " :colorscheme molokai           "one hell of a amazing great-magenta colorscheme
endif
""" Abbreviations
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

function! MakeSpacelessIabbrev(from, to)
    execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

call MakeSpacelessIabbrev('gh/',  'http://github.com/')

cabbr %% <C-R>=expand('%:p:h')<CR>
map <leader>e :edit %%
" cnoremap %% <C-R>=expand('%:h').'/'<cr>
cabbr jobs /Users/iaj/Documents/jobs/
cabbr stud /Users/iaj/Documents/studying/
" Expand abbreviations in command mode...
cmap <C-\> <C-]>

""" Statusline
if !(has('gui_running'))
    hi User1 guifg=green guibg=#363946 ctermfg=green ctermbg=237 gui=bold guifg=#e0e0e0 guibg=#363946
    " magenta
    hi User2 term=bold cterm=bold ctermfg=161 gui=bold guifg=#F92672 guibg=#363946 ctermbg=237
    " cyan
    hi User3 term=bold cterm=bold ctermfg=81 gui=bold guifg=#66d9ef guibg=#363946 ctermbg=237
    set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)%P\ %{fugitive#statusline()}%*"
endif
""" my own Supertab TODO
" Remap the tab key to do autocompletion or indentation depending on the
" context
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
""" Functions
"""" Shell
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 
"""" Gist
" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
"""" Scratch
command! ScratchToggle call ScratchToggle()
function! ScratchToggle() " {{{
  if exists("w:is_scratch_window")
    unlet w:is_scratch_window
    exec "q"
  else
    exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
    let w:is_scratch_window = 1
  endif
endfunction " }}}
nnoremap <silent> <leader><tab> :ScratchToggle<cr>
""" Mappings
"""" Ease of use
" Most important things first
cnoremap jk <C-c>
imap jk <Esc>

" Clear the search buffer when hitting return -- <C-L> now
" ... or <C-L> in insert mode
" nnoremap <CR> :nohlsearch<cr>
inoremap <C-L> <C-O>:nohls<CR>
" noremap <C-L> :nohlsearch<CR><C-L>
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Unfortunately this baby only works on MacVim
" No matter where the cursor insert and edit a new line below.
inoremap <c-cr> <esc>A<cr>

" Toggle absolute/relative linenumbering
nnoremap <silent> ,A :if &l:nu \| setl rnu \| else \| setl nu \| endif<CR>

nnoremap <leader><leader> <c-^>

" Y behaves like D rather than like dd
nnoremap Y y$
" Backspace should delete to the black hole register, not move left
nnoremap <BS> "_X

" Hilight everything in visual mode that was just pasted!
nnoremap <Leader>V '[V']

" Toggle wrapping with <leader>w
map <leader>w :set invwrap<cr>:set wrap?<cr>
map <silent> <leader>d :bd<CR>
map <leader>e :e <C-R>=expand("%:h")<cr>/

runtime $HOME/vim-addons/matchit.zip/plugin/matchit.vim
map <tab> %
" Delete all buffers
" nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>
" Don't pollute my registers plz
nnoremap <C-w><C-w> <C-w>p
nmap dD "_dd

" Global substitution
nnoremap <leader>s<Space> :%s//g<left><left>

" Change directory to the current file dir
nnoremap <leader>D :lcd %:h<cr>:pwd<cr>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Fuck you 2 manual key
nnoremap K <nop>

" Awesome, inserts new line without going into insert mode
map <S-Enter> O<ESC>D

" No comment lines - we just don't want them sumtimes
nmap go o<Esc>S
nmap gO O<Esc>S

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Return to visual mode after indenting
xmap < <gv
xmap > >gv
" Pressing an 'enter visual mode' key while in visual mode changes mode.
vmap <C-V> <ESC>`<<C-v>`>
vmap V     <ESC>`<V`>
"vmap v     <ESC>`<v`>
vnoremap v <ESC>

" Highlights the current typed word (all occasions)
imap <F2> <esc>:let @/=expand("<cword>") \| set hls<cr>a

" Extra functionality for some existing commands:
" <C-6> switches back to the alternate file and the correct column in the line.
nnoremap <C-6> <C-6>`"
" CTRL-g shows filename and buffer number, too.
nnoremap <C-g> 2<C-g>

" Make [[ and ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{$', 'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{$', 'ebsW') && (setpos("''", getpos('.'))
            \ <bar><bar> 1) ? "''" : "\<ESC>")
onoremap <expr> ]] (search('^\S\@=.*{$', 'esW') && (setpos("''", getpos('.'))
            \ <bar><bar> 1) ? "''" : "\<ESC>")

" It's 2012
nnoremap j gj
nnoremap k gk
command! W :w

" Swap 2 words
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

" Omnicompletion like in several IDEs
inoremap <C-Space> <C-X><C-O>

" Add semicolon to the end of the line.
nnoremap <silent> <leader>; :call setline(line('.'), getline('.') . ';')<CR>
nnoremap <silent> <leader>; :call setline(line('.'), getline('.') . ';')<CR>

" Removes superfluous blank lines..
map \L :g/^\s*\n\s*$/d<CR>

" Clean trailing whitespace
nnoremap \W :%s/\s\+$//<cr>:let @/=''<cr>
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
" Undo in insert mode
" make it so that if I accidentally press ^W or ^U in insert mode,
" then <ESC>u will undo just the ^W/^U, and not the whole insert
" This is documented in :help ins-special-special, a few pages down
inoremap <C-W> <C-G>u<C-W>
inoremap <C-U> <C-G>u<C-U>

" Format Text-Mate Style
map Q gqip

" Write to file with sudo
cmap w!! w !sudo tee % >/dev/null

imap <C-J> <Down>
imap <C-K> <Up>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_
"""" Remap command-line-editing keys
cnoremap <C-A>     <Home>
cnoremap <ESC>b    <S-Left>
cnoremap <ESC>f    <S-Right>
cnoremap <ESC><BS> <C-W>
cnoremap <C-E>      <End>
" cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>
"cnoremap <C-B>      <Left>
"""" Error navigation
"
"             Location List     QuickFix Window
"            (e.g. Syntastic)     (e.g. Ack)
"            ----------------------------------
" Next      |     M-j               M-Down     |
" Previous  |     M-k                M-Up      |
"            ----------------------------------
nnoremap <M-j> :lnext<cr>zvzz
nnoremap <M-k> :lprevious<cr>zvzz
inoremap <M-j> <esc>:lnext<cr>zvzz
inoremap <M-k> <esc>:lprevious<cr>zvzz
nnoremap <M-Down> :cnext<cr>zvzz
nnoremap <M-Up> :cprevious<cr>zvzz
"""" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc><right>
"""" Execute current line
function! ExecuteLine()
    let save_reg = @@
    normal ^y$
    exe @@
    let @@ = save_reg
endfunction
nnoremap <silent> <leader>i :call ExecuteLine()<CR>
"""" Window movement/resizing enhancements
" create a new vertical split window and switch over to it
nnoremap <leader>W <C-w>v<C-w>l
nnoremap <leader>H <C-w>s<C-w>j
" Close the window below this one
noremap <silent> <leader>cj :wincmd j<cr>:close<cr>
" Close the window above this one
noremap <silent> <leader>ck :wincmd k<cr>:close<cr>
" Close the window to the left of this one
noremap <silent> <leader>ch :wincmd h<cr>:close<cr>
" Close the window to the right of this one
noremap <silent> <leader>cl :wincmd l<cr>:close<cr>
" Close the current window
noremap <silent> <leader>cd :close<cr>
" Move the current window to the right of the main Vim window
noremap <silent> <leader>ml <C-W>L
" Move the current window to the top of the main Vim window
noremap <silent> <leader>mk <C-W>K
" Move the current window to the left of the main Vim window
noremap <silent> <leader>mh <C-W>H
" Move the current window to the bottom of the main Vim window
noremap <silent> <leader>mj <C-W>J

noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Mappings for fast resizing windows
" Use - and + to resize horizontal splits
map - <C-W>-
map + <C-W>+
" ...and for vsplits with alt-< or alt->
map <M-,> 3<C-W><
map <M-.> 3<C-W>>
" Shrink the current window to fit the number of lines in the buffer.  Useful
" for those buffers that are only a few lines
nmap <silent> ,sw :execute ":resize " . line('$')<cr>
"""" Folding
noremap <leader>0 :set fdl=0<CR>
noremap <leader>1 :set fdl=1<CR>
noremap <leader>2 :set fdl=2<CR>

" Toggles folds with <Space>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz
"""" Spellchecking
nmap <Leader>ss :set nospell<CR>
nmap <Leader>se :set spell spelllang=en<CR>
nmap <Leader>sd :set spell spelllang=de<CR>

" Quickly add a new spelling abbreviation for the word under cursor to this file.
nmap <C-F6> :let tmp=@f<CR>"fyaw<Esc>:bot split ~/.vimrc<CR>G?LAST_SPELL<CR>zRkoiab<Space><Esc>"fp<Esc>:let @f=tmp<CR>a
"""" Quick editing
nnoremap \v <C-w><C-v><C-l>:e ~/dotfiles/.vimrc<cr>
nnoremap \z <C-w><C-v><C-l>:e ~/dotfiles/.zshrc<cr>
nnoremap \p <C-w><C-v><C-l>:e ~/.pentadactylrc<cr>
noremap \ft :exec 'e ~/.vim/after/ftplugin/'.&filetype.'.vim'<cr>
noremap \fs :exec 'e ~/.vim/syntax/'.&filetype.'.vim'<cr>
noremap \fx :exec 'e ~/.vim/xpt-personal/ftplugin/'.&filetype.'/'.&filetype.'.xpt.vim'<cr>
"""" Quick sourcing
map <silent> <leader>ms :messages<CR>
map <silent> <leader>sv :source $HOME/dotfiles/.vimrc<CR>
map <silent> <leader>sf :source %<CR>
"""" Quick filetype switching
nnoremap \st :set ft=typoscript<CR>
nnoremap \sl :set ft=tex<CR>
nnoremap \sh :set ft=html<CR>
nnoremap \sc :set ft=css<CR>
nnoremap \sj :set ft=javascript<CR>
nnoremap \sp :set ft=php<CR>
nnoremap \sw :set ft=mail<CR>
nnoremap \sx :set ft=xml<CR>
"""" Get syntax highlighting group
" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <leader>sa :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
            \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
            \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
            \ . ">"<CR>
"""" Highlight words
nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>
"""" Warnings - learn your VIM
inoremap <Esc> <Esc>:echo "You should use Ctrl-[, or rather 'jk'"<CR>
"inoremap <BS> <Esc>:echo "You should use Ctrl-H"<CR>

" Learn your hjkl!
nmap <Left>     <Esc>:echo "You should have typed h instead"<CR>
nmap <Right>    <Esc>:echo "You should have typed l instead"<CR>
nmap <Up>       <Esc>:echo "You should have typed k instead"<CR>
nmap <Down>     <Esc>:echo "You should have typed j instead"<CR>
"""" Faster scrolling
" nnoremap <C-e> 3<C-e>
" nnoremap <C-y> 3<C-y>
"""" Improved Searching
" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
" Search the current file for what's currently in the search register and display matches
nmap <silent> _gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Search the current file for the word under the cursor and display matches
nmap <silent> _gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" Search the current file for the WORD under the cursor and display matches
nmap <silent> _gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Use very magic mode in order to use () instead of \(\) etc.
" nnoremap / /\v
" vnoremap / /\v
"""" Ack motions

" Motions to Ack for things.  Works with pretty much everything, including:
"
"   w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects
"
" Awesome.
"
" NOTE: If the text covered by a motion contains a newline it won't work.  Ack
" searches line-by-line.
nnoremap <silent> \a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> \a :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@
    call s:CopyMotionForType(a:type)
    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"
    let @@ = reg_save
endfunction
"""" TODO: check those out
" noremap <F3> :!sed -e (regex) && doxygen yourproject doc && zip -r release.zip doc src
" Easier to type, and I never use the default behavior.
" noremap H ^
" noremap L g_
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"             \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
""" Additional colors...
hi InterestingWord1 guifg=#000000 guibg=#FFA700
hi InterestingWord2 guifg=#000000 guibg=#53FF00
hi InterestingWord3 guifg=#000000 guibg=#FF74F8
"" vim:fdm=expr:fdl=0
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
