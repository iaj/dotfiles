" Vim syntax file
" Language:     trainingslog
" Maintainer:   iaj (tyberion@googlemail.com)
" Last Change:  2011 Dec 21

syntax clear

exec 'hi User9 guifg=#F92672'

" syn match tlogDate "\d\d\d\d-\d\d-\d\d"
syn match Number "\d\+\(\d\|\.\|,\|%\|\~\)*"
syn match Arrow "▸"

syn match tlogWeight "weight"
syn match tlogEx "\<\(squats\|dips\|deadlifts\|chinups\|pullups\|bench\ presses\|barbell\ rows\|military\ presses\|pulldowns\|ng\ dumbell\ presses\|ng\ chinups\|barbell\ drag\ curls\|zottmann\ curls\|overhead\ extensions\|calv\ raises\|crunches\|walkouts\|pushups\|bulgarian\ split\ squats\?\)\>"
syn match tlogSpecial "\<\(workout\|meal\|progresspic\|measurements\S*\)\>"
syn match tlogSpecial "\(\(last\|former\)\ workouts\|weights\|etc\|progress\ images\|motivational\ pics\|formulas\|goals\)"
syn match tlogFeast "\<\(refeed\|feast\|fast\)\>"
syn match tlogPic "pics/\S*"
" syn match innerBrackets "(\zs[^)]*\ze)"
syn region innerBrackets start=/(/hs=s+1 end=/)/he=e-1
" \@<= doesn't add stuff to the matching
" syn match tlogUserComments "\(^comments (\)\@<=[^)]*\ze)"
syn match tlogUserHWords "^\(comments\|formula\|trails\|Vascularity\|[Ll]eangains\|[cC]heckpoint[sS]*\|[gG][oO][aA][lL][sSzZ]*\)\>"
syn match tlogDaytimeWords "\(@noon\|@eve\|@morning\|@\d\+:\d\+\(am\|pm\)\)"
syn match tlogWeightUnits "\(pd\|kg\|pounds\|kilograms\|grams\?\|calories\|kcals\?\)\>"
syn match tlogMasses "\(\(f\|l\|t\)bm\|kf\)"

" syntax region Comment   start=+comments (+  skip=+comments (+  end=+)+
syntax region tlogUserComments start="\(^comments \)\@<=("hs=s+1 end=/)/he=e-1
syn match tlogDate "\d\d\d\d\ \(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\ \d\d"
syn match tlogDay "\<\(Sat\|Sun\|Mon\|Tue\|Wed\|Thu\|Fri\)\>"

syn match tlogMeasure "\<\(brustfalte\|beinfalte\|bauchfalte\|bauchumfang\|kf\/lbm\/fat\|bmr\)\>"

call matchadd('Todo', '\(Author\)')
syn match tlogComm /#.*/
syn match key "<\u\d>"

hi tlogDate guifg=#268bd2
" hi def link tlogDay tlogDate
hi def link tlogDay PreProc

hi Successful_Test guifg=#A8FF60, guibg=#A8FF60

hi tlogMeasure guifg=#cb4b16

" hi def link tlogDate IncSearch
hi def link tlogEx Number
hi def link tlogSpecial String
hi def link tlogFeast String
hi def link tlogPic Number
hi def link innerBrackets Statement

hi def link tlogUserHWords PreProc
hi def link tlogDaytimeWords PreProc
hi def link Arrow PreProc
hi def link tlogMasses PreProc
" hi def link tlogUserComments String
hi def link tlogUserComments Comment
" hi def link tlogMeasure String
hi def link tlogComm Comment
hi def link key Special

hi def link tlogWeight Function
hi def link tlogWeightUnits tlogWeight

" call matchadd('Identifier', '\(lemma\|byte\|bit\)')
" call matchadd('Statement', '\(even\|half\|nat2byte\|dbl\|byte2nat\|byte-add\|byte-inc\|byte-mult\)')
" call matchadd('String', '\(lsb\|rshift\|mkbyte\|ε\|\<I\>\|\<o\>\)')
" call matchadd('Number', '\(\<n\>\|\<z\>\|\<x\>\|\<y\>\|ε\|\<I\>\|\<o\>\)')
" call matchadd('Number', '\d\d\d\d')
" call matchadd('User9', '\(\<lemma stops\>\)')
" call matchadd('Successful_Test', '\(\<success\)')

" attach Highlighting to HTML stuff
syn cluster mailLinks		contains=mailURL,mailEmail
syn match mailURL contains=@NoSpell `\v<(((https?|ftp|gopher)://|(mailto|file|news):)[^' 	<>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^' 	<>"]+)[a-z0-9/]`
hi def link mailURL		String
