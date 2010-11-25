" Author:  iaj (tyberion@googlemail.com)
" Feel free to do whatever you would like with this file as long as you give
" credit where credit is due.
"
" NOTE:
" If you're editing this in Vim and don't know how folding works, type zR to
" unfold everything.  And then read ":help folding".

" Skip this file unless we have +eval and Vim 7.0 or greater.  With an older
" Vim, I'd rather just plain ol' vi emulation reminding me to upgrade.

"" " Settings

""" Settings
filetype off
" apply all the plugins to our current vim sessions - thanks pathogen ツ
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set t_Co=256
syntax enable
set lazyredraw				" Avoid redrawing the screen mid-command.
set undolevels=1000
set encoding=utf-8
let mapleader = ","
set guioptions=Aci
set antialias
set guifont=Monaco:h12
set title
set isfname-=\=

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
"test

"dont load csapprox if no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
else
    "if has("gui_gnome")
	"set term=gnome-256color
	"colorscheme 256_ir_black
    "endif
    "if has("gui_mac") || has("gui_macvim")
	"colorscheme 256_ir_black
	"set guifont=Menlo:h13
    "endif
    "if has("gui_win32") || has("gui_win32s")
	"set guifont=Consolas:h12
	"colorscheme 256_ir_black
    "endif
endif

""" Sourcing ~/.vimrc
source /Users/iaj/.vim/personal/scripts/remappings
source /Users/iaj/.vim/personal/scripts/mappings
source /Users/iaj/.vim/personal/scripts/functions
source /Users/iaj/.vim/personal/scripts/autocommands

source /Users/iaj/.vim/personal/scripts/galal
"
"  Titlebar string: hostname> ${PWD:s/^$HOME/~} || (view|vim) filename ([+]|)
let &titlestring  = hostname() . '> ' . '%{expand("%:p:~:h")}'
                \ . ' || %{&ft=~"^man"?"man":&ro?"view":"vim"} %f %m'

set nocompatible
set nocursorcolumn
set magic
set cursorline
" Files that should be ignored by default - in completition as well as in Command-T
set wildignore=.backup,.dropbox,.gem,.cheat,.DS_Store,.fontconfig,.hamachi,.class,.git,.o,.svn,.toc,.obj,.bmp,.jp*g,.png

" Moving Around/Editing
set whichwrap=b,s,h,l,<,>	" <BS> <Space> h l <Left> <Right> can change lines
set virtualedit=block		" Let cursor move past the last char in <C-v> mode
set scrolloff=3			" Keep 3 context lines above and below the cursor
set backspace=indent,eol,start

set showmatch			" Briefly jump to a paren once it's balanced
set matchtime=2			" (for only .2 seconds).

" Searching and Patterns
set ignorecase			" Default to using case insensitive searches,
set smartcase			" unless uppercase letters are used in the regex.
set hlsearch			" Highlight searches by default.
set incsearch			" Incrementally search while typing a /regex

" Windows, Buffers
set noequalalways		" Don't keep resizing all windows to the ~/.vimrc
set hidden			" Hide modified buffers when they are abandoned
set swb=useopen,usetab		" Allow changing tabs/windows for quickfix/:sb/etc
set splitright			" New windows open to the right of the current one

" Insert completion
set completeopt-=preview	" Don't show preview menu for tags.
set complete=.,w,b,t
set infercase			" Try to adjust insert completions for case.

" Folding
set foldmethod=syntax		" By default, use syntax to determine folds
set foldlevelstart=99		" All folds open by default

" Text Formatting
set formatoptions=q		" Format text with gq, but don't format as I type.
set formatoptions+=n		" gq recognizes numbered lists, and will try to
set formatoptions+=1		" break before, not after, a 1 letter word

" Display
"set number			" Display line numbers
set relativenumber
set numberwidth=1		" using only 1 column (and 1 space) while possible
set nowrap

if &enc =~ '^u\(tf\|cs\)' " When running in a Unicode environment,
    set list		      " visually represent certain invisible characters:
    let s:arr = nr2char(9655) " using U+25B7 (▷) for an arrow, and
    let s:dot = nr2char(8901) " using U+22C5 (⋅) for a very light dot,
    " display tabs as an arrow followed by some dots (▷⋅⋅⋅⋅⋅⋅⋅),
    exe "set listchars=tab:"	. s:arr . s:dot
    " and display trailing and non-breaking spaces as U+22C5 (⋅).
    exe "set listchars+=trail:" . s:dot
    exe "set listchars+=nbsp:"	. s:dot
    " Also show an arrow+space (↪ ) at the beginning of any wrapped long lines?
    " I don't like this, but I probably would if I didn't use line numbers.
    let &sbr=nr2char(8618).' '
endif

set confirm			" Y-N-C prompt if closing with unsaved changes.
"set cmdheight=2		" Prevent "Press Enter" message after most commands
set showcmd			" Show incomplete normal mode commands as I type.
set report=0			" :commands always print changed line count.
set shortmess+=a		" Use [+]/[RO]/[w] for modified/readonly/written.
set shortmess+=A		" Don't show message on existing swapfile
set ruler			" Show some info, even without statuslines.
set laststatus=2		" Always show statusline, even if only 1 window.
set autoindent

set notimeout ttimeout ttimeoutlen=200

function! SlSpace()
    if exists("*GetSpaceMovement")
	return "[" . GetSpaceMovement() . "]"
    else
	return ""
    endif
endfunc

" Tabs/Indent Levels
set tabstop=8			" NEVER change this!
"set tabstop=4  " GRB SETTING (gary bernhard)
set shiftwidth=4
set softtabstop=4
"set expandtab			" Use spaces, not tabs, for autoindent/tab key.
set smarttab
set noexpandtab
set mousehide
set mousem=popup
set undofile
set undodir=~/.vim/undo

"Print options
set printoptions+=syntax:n	" Print syntax highlighting.
"set printoptions+=number:y	" Print line numbers.

" Tags
set tags=./tags;$HOME
"set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,/Users/tags
"set tags+=tags;/
set showfulltag			" Show more information while completing tags.

" Reading/Writing
set noautowrite			" Never write a file unless I request it.
set noautowriteall		" NEVER.
set noautoread			" Don't automatically re-read changed files.
set modeline			" Allow vim options to be embedded in files;
set modelines=5			" they must be within the first or last 5 lines.
set ffs=unix,dos,mac		" Try recognizing dos, unix, and mac line endings.

" Backups/Swap Files
" Make sure that the directory where we want to put swap/backup files exists.
if ! len(glob("~/.backup/"))
    echomsg "Backup directory ~/.backup doesn't exist!"
endif

set history=10000
set writebackup			" Make a backup of the original file when writing
set backup			" and don't delete it after a succesful write.
set backupskip=			" There are no files that shouldn't be backed up.
set backupdir^=~/.backup	" Backups are written to ~/.backup/ if possible.
set directory^=~/.backup	" Swap files are also written to ~/.backup, too.
set updatetime=500		" Write swap files after 2 seconds of inactivity.
set backupext=~			" Backup for "file" is "file~"

"""" Command Line
set wildmenu			" Menu completion in command mode on <Tab>
set wildmode=longest,list	" <Tab> cycles between all matching choices.
set wcm=<C-Z>			" Ctrl-Z in a mapping acts like <Tab> on cmdline
"set timeoutlen=100

" Per-Filetype Scripts
" NOTE: These define autocmds, so they should come before any other autocmds.
"	That way, a later autocmd can override the result of one defined here.
filetype on			" Enable filetype detection,
filetype indent on		" use filetype-specific indenting where available,
filetype plugin on		" also allow for filetype-specific plugins,
syntax on			" and turn on per-filetype syntax highlighting.
set grepprg=grep\ -nH\ $*
set gdefault
""" Plugin Settings
" Eclim settings
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

" Supertab settings
" supertab + eclim == java win
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
"Taglist Settings (eg. show tags only for the current file)
let g:Tlist_Show_One_File = 1
"let Tlist_Max_Tag_Length = 200
let Tlist_WinWidth=40
let g:SuperTabLongestHighlight = 1
" XPTemplate Settings
"let g:xptemplate_vars = "$author=iaj (tyberion@googlemail.com)"
"let g:xptemplate_vars = '$author=iaj&$email=tyberion@googlemail.com'
"let g:xptemplate_vars += "$email=tyberion@googlemail.com"
let g:xptemplate_brace_complete = 0
let g:is_posix=1		" I don't use systems where /bin/sh isn't POSIX.
"let g:Tlist_Ctags_Cmd = "~/bin/ctags"
let g:xptemplate_vars = "$author=iaj\ (tyberion@googlemail.com)&$email=tyberion@gmail.com&"

"sparkup settings
let g:sparkupExecuteMapping = '<D-e>'
" disable warnings from NERDCommenter:
let g:NERDShutUp = 1
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
"let g:space_loaded = 1

let g:loaded_delimitMate = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_smart_quotes = 0
let delimitMate_excluded_ft = "mail html"

let g:yankring_history_dir = '~/.vim/'
let g:tex_flavor='latex'

" Fuzzy Finder Settings
let g:fuf_modesDisable = []
let g:fuf_mrucmd_maxItem = 2000

"let g:CommandTCancelMap = ['<C-c>']
let g:CommandTMaxHeight = 20
let g:CommandTMaxFiles=3000
"let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
"let g:CommandTMatchWindowAtTop=1

" netrw settings
let g:netrw_altv	  = 1
let g:netrw_fastbrowse	  = 2
let g:netrw_keepdir	  = 0
let g:netrw_liststyle	  = 2
let g:netrw_retmap	  = 1
let g:netrw_silent	  = 1
let g:netrw_special_syntax= 1

""" dimensions for MacVim + MacVim colorscheme
if has('gui_running')
    "set lines=38
    "colorscheme zenburn			"tha best fricken fucken theme on earth
    "colorscheme xoria256
    "colorscheme darktango
    "set columns=153
    set lines=50
    set columns=200
    "colorscheme darktango
    "colorscheme slate
    "colorscheme herald
    "pretty dark but nice theme
    "colorscheme cloudsmidnight

    "colorscheme twilight
    "colorscheme twilight2
    "Molokai Settings
    let g:molokai_original = 1
    "colorscheme molokai
    colorscheme mustang
    "hi Visual guibg=#999999
    "let g:obviousModeInsertHi = "guibg=Black guifg=White"
    "hi Visual term=reverse cterm=reverse guifg=#ce5c00 guibg=#fcaf3e

    highlight SpellBad term=underline gui=undercurl guisp=Orange
    " a little tweaking to get that zenburn better for my lazy eyes ;)
    "Zenburn Settings
    "let g:zenburn_high_Contrast = 1
    "colorscheme zenburn
    "hi incsearch ctermbg=216 ctermfg=242
    "hi search ctermbg=223 ctermfg=238
else
    "colorscheme xoria256
    colorscheme molokai		"one hell of a amazing great-magenta colorscheme
    "colorscheme ir_black_dunolie
endif

""" Miscellaneous - to check out

augroup Vimperator
    au! BufRead vimperator-* nnoremap <buffer> ZZ :call FormFieldArchive() \| :silent write \| :bd \| :macaction hide:<CR>
augroup end

" Netrw explorer
if has("eval")
  let g:netrw_keepdir = 1                       " does not work!
  let g:netrw_list_hide = '.*\.swp\($\|\t\),.*\.py[co]\($\|\t\)'
  let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$,\.py[co]$'
  let g:netrw_timefmt = '%Y-%m-%d %H:%M:%S'
  let g:netrw_use_noswf = 1
endif
"" vim:fdm=expr:fdl=0
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
