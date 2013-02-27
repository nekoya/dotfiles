nnoremap <buffer> <F1> :vs<CR>:vimgrep /\(^\s*def \\|^class \)/ %<CR>:cw<CR><C-w>k:q<CR><C-w>l
nnoremap <buffer> <F3> :!python %<CR>
nnoremap <buffer> <F4> :!nosetests -sv %<CR>
