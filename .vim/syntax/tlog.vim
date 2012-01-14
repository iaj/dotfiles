" Vim syntax file
" Language:     trainingslog
" Maintainer:   iaj (tyberion@googlemail.com)
" Last Change:  2011 Dec 21

syntax clear

exec 'hi User9 guifg=#F92672'
exec 'hi Successful_Test guifg=#A8FF60, guibg=#A8FF60'

syn match tlogDate "\d\d\d\d-\d\d-\d\d"

syn match tlogEx "\(squats\|deadlifts\|chinups\|bench\ presses\|barbell\ rows\|militaries\)"
syn match innerBrackets "(\zs[^)]*\ze)"
syn match tlogPic "pics/\S*"
syn match tlogComments "^comments\S*(\zs[^)]*\ze)"
syn match tlogComment "^comments\>"

hi def link tlogDate PreProc
hi def link tlogEx Number
hi def link tlogPic Number
hi def link innerBrackets Statement
hi def link tlogComment PreProc
hi def link tlogComments String

" call matchadd('Identifier', '\(lemma\|byte\|bit\)')
" call matchadd('Statement', '\(even\|half\|nat2byte\|dbl\|byte2nat\|byte-add\|byte-inc\|byte-mult\)')
" call matchadd('String', '\(lsb\|rshift\|mkbyte\|ε\|\<I\>\|\<o\>\)')
" call matchadd('Number', '\(\<n\>\|\<z\>\|\<x\>\|\<y\>\|ε\|\<I\>\|\<o\>\)')
" call matchadd('Number', '\d\d\d\d')
" call matchadd('User9', '\(\<lemma stops\>\)')
" call matchadd('Successful_Test', '\(\<success\)')
