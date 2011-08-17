nnoremap <buffer> <F3> :!python %<CR>
nnoremap <buffer> <F1> :vs<CR>:vimgrep /^\s*def / %<CR>:cw<CR><C-w>k:q<CR><C-w>l
