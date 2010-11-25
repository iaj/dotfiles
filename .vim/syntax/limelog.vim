" lime Log syntax file
" Language:	Limechat log
" Maintainer:	iaj (tyberion@googlemail.com)
" GetLatestVimScripts: xxxx 1 :AutoInstall: limelog.vim
"
" Based on work by TODO

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = 'limelog'

setlocal iskeyword+=45,91-96,124

syntax spell notoplevel

syntax region  limeLogMsg	start='^---' end='$'

syntax match   limeTimestamp	'^\d\{2}:\d\{2}\(:\d\{2}\)\?' nextgroup=@limeItems skipwhite

syntax region  limeNickRegion	matchgroup=limeDelimiter start='<' end='>' contained contains=@limeNicks
"syntax match   limeNick	'[ @~&+]\=\<\k*\>' contained
syntax match   limeNick	'iaj' contained

syntax match   limeAction	'\* \k* ' contained
syntax region  limeMsg		start='-!-' end='$' contained
syntax region  limeNotice	start='\*\{3}' end=':' contained

syntax cluster limeItems	contains=limeNickRegion,limeAction,limeMsg,limeNotice
syntax cluster limeNicks	contains=limeNick

if version >= 508 || !exists("did_limelog_syntax_inits")
  if version < 508
    let did_limelog_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink limeLogMsg PreProc
  HiLink limeTimestamp Number
  HiLink limeAction Type
  HiLink limeMsg Identifier
  HiLink limeNotice PreProc

  delcommand HiLink
endif

if filereadable($HOME . '/.lime/saved_colors') && !exists("limelog_no_saved_nick_colors")

  let s:colormap = [0, 4, 2, 9, 1, 5, 3, 11, 10, 6, 14, 12, 13, 8, 7, 15]

  for s:line in readfile($HOME . '/.lime/saved_colors')
    let s:words = split(s:line, ':')
    let s:nick = escape(s:words[0], '\.*[^$')
    let s:clean = substitute(s:words[0], '[^_a-zA-Z0-9]', '_', 'g')
    let s:color = s:colormap[s:words[1] - 1]

    exec 'syntax match limeNick_' . s:clean . ' /[ @~&+]\=\<' . s:nick . '\>/ contained'
    exec 'syntax cluster limeNicks add=limeNick_' . s:clean
    exec 'highlight limeNick_' . s:clean . ' ctermfg=' . s:color . ' guifg=' . s:color
  endfor

  unlet s:colormap s:line s:words s:nick s:clean s:color
endif
