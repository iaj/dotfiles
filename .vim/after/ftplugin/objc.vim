autocmd Filetype objc inoremap <C-Space> <c-r>=MyControlSpace()<cr>
" :nmap <buffer> <silent> K :call objc#man#ShowDoc()<cr>
":setlocal makeprg=xcodebuild\ -configuration\ Debug
" :setlocal errorformat=%f:%l:\ error:\ %m,%f:%l:\ warning:\ %m
nmap <buffer> <silent> <leader>id :silent !xed %<cr>
" nmap <buffer> <silent> <leader>bu :mak!<CR>
" set makeprg=xcodebuild\ -activetarget\ -activeconfiguration
" set makeprg=xcodebuild\ -activetarget\ -activeconfiguration

" source $HOME/.vim/personal/scripts/objctagjump

setlocal errorformat=%f:%l:\ error:\ %m,%f:%l:\ warning:\ %m
" :setlocal makeprg=xcodebuild\ -configuration\ Debug
set isk+=58
" au FileType objc set makeprg=gcc\ -framework\ Foundation\ %\ -o %:p:h
"
setlocal makeprg=xcodebuild
" setlocal makeprg=xcodebuild -configuration Debug clean build
command! A :Alternate

" let s:arr = nr2char(9655) " using U+25B7 (▷) for an arrow, and
" let s:dot = nr2char(8901) " using U+22C5 (⋅) for a very light dot,
" exe "setlocal listchars-=tab:" . s:arr . s:dot
" remove tab-spaces :S
setlocal nolist
" example mapping for building.. needs to get improved though
" map ,t :w|:!xcodebuild -project ~/git/Quicksilver/Quicksilver/Quicksilver.xcodeproj<CR>
"
"xcode make program
" let prg="xcodebuild"
" let makepath=$MAKEPATH
" let &makeprg="cd ".$BASE.";".prg.' '.makepath
""/Users/user/Project/Classes/stuff.m:46: error: 'somecrap' was not declared
