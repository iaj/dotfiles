" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs><space><space><space><space>
inoremap <buffer> {<cr> {}<left><cr>.<cr><esc>kA<bs><space><space><space><space>
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" Use <leader>S to sort properties.  Turns this:
"     p {
"         width: 200px;
"         height: 100px;
"         background: red;
"
"         ...
"     }
" into this:
"     p {
"         background: red;
"         height: 100px;
"         width: 200px;
"
"         ...
"     }
nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
