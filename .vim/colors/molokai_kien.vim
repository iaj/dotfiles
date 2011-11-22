let g:colors_name = 'molokai'
let s:original = exists('g:molokai_original') ? g:molokai_original : 1

hi Boolean guifg=#AE81FF
hi Character guifg=#E6DB74
hi Conditional guifg=#F92672 gui=none
hi Constant guifg=#AE81FF gui=none

hi ColorColumn guibg=#20211B
hi Conceal guifg=#A61060 guibg=#000000
hi Cursor guifg=#000000 guibg=#DDDDDD
hi vCursor guifg=#000000 guibg=#10B9CF
hi link lCursor vCursor
hi Debug guifg=#BCA3A3 gui=none
hi Define guifg=#66D9EF
hi Delimiter guifg=#8F8F8F

hi DiffAdd guibg=#13354A
hi DiffChange guifg=#89807D guibg=#4C4745
hi DiffDelete guifg=#A61060 guibg=#1E0010
hi DiffText guibg=#4C4745 gui=none

hi Directory guifg=#A6E22E gui=none
hi Error guifg=#A61060 guibg=#1E0010 gui=bold
hi ErrorMsg guifg=#F92672 guibg=#232526 gui=none
hi Exception guifg=#A6E22E gui=none
hi Float guifg=#AE81FF
hi FoldColumn guifg=#768487 guibg=#171812
hi Folded guifg=#768487 guibg=#171812

hi Function guifg=#A6E22E
hi Identifier guifg=#FD971F
hi Ignore guifg=#808080 guibg=bg
hi IncSearch guifg=#C4BE89 guibg=#000000
hi Keyword guifg=#F92672 gui=none
hi Label guifg=#E6DB74 gui=none
hi Macro guifg=#C4BE89 gui=none
hi MatchParen guifg=#000000 guibg=#BD5700 gui=none
hi ModeMsg guifg=#E6DB74
hi MoreMsg guifg=#E6DB74
hi Number guifg=#AE81FF
hi Operator guifg=#F92672

" Complete/Popup menu
hi Pmenu guifg=#66D9EF guibg=#000000
hi PmenuSbar guibg=#080808
hi PmenuSel guibg=#808080
hi PmenuThumb guifg=#66D9EF

hi PreCondit guifg=#A6E22E gui=none
hi PreProc guifg=#A6E22E
hi Question guifg=#66D9EF
hi Repeat guifg=#F92672 gui=none
hi Search guifg=#DDDDDD guibg=#354344

" Marks column
hi SignColumn guifg=#A6E22E guibg=#232526
hi Special guifg=#66D9EF guibg=bg gui=none
hi SpecialChar guifg=#F92672 gui=none
hi SpecialComment guifg=#465457 gui=none
hi SpecialKey guifg=#585A55 gui=none

if has('spell')
hi SpellBad guisp=#FF0000 gui=undercurl
hi SpellCap guisp=#7070F0 gui=undercurl
hi SpellLocal guisp=#70F0F0 gui=undercurl
hi SpellRare guisp=#DDDDDD gui=undercurl
endif

hi Statement guifg=#F92672 gui=none
hi StatusLine guifg=#DDDDDD guibg=#00798F gui=none
hi StatusLineNC guifg=#808080 guibg=#080808
hi StorageClass guifg=#ED870F gui=none
hi String guifg=#D6CB64
hi Structure guifg=#66D9EF

hi TabLine guifg=#85816E guibg=#20211B gui=none
hi TabLineFill guifg=#85816E guibg=#171812 gui=none
hi TabLineSel guifg=#A6E22E guibg=#3B3A32 gui=none

hi Tag guifg=#F92672 gui=none
hi Title guifg=#EF5939 gui=none
hi Todo guifg=#DDDDDD guibg=bg gui=none

hi Type guifg=#66D9EF gui=none
hi Typedef guifg=#66D9EF
hi Underlined guifg=#808080 gui=underline

hi VertSplit guifg=#808080 guibg=#080808 gui=none
hi Visual guibg=#403D3D
hi VisualNOS guibg=#403D3D
hi WarningMsg guifg=#DDDDDD guibg=#333333 gui=none
hi WildMenu guifg=#66D9EF guibg=#000000

if s:original
hi Normal guifg=#CCCCCC guibg=#272822 gui=none
hi Comment guifg=#85816E
hi CursorLine guibg=#3E3D32
hi CursorColumn guibg=#3E3D32
hi LineNr guifg=#BCBCBC guibg=#3B3A32
hi NonText guifg=#888888 guibg=#272822
el
hi Normal guifg=#CCCCCC guibg=#1B1D1E gui=none
hi Comment guifg=#465457
hi CursorLine guibg=#293739
hi CursorColumn guibg=#293739
hi LineNr guifg=#BCBCBC guibg=#232526
hi NonText guifg=#888888 guibg=#232526
en
