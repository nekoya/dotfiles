setlocal dictionary=~/.vim/dict/perl_functions.dict
nnoremap <buffer> <F1> :vs<CR>:vimgrep /^\s*sub / %<CR>:cw<CR><C-w>k:q<CR><C-w>l
nnoremap <buffer> <F3> :!perl %<CR>
nnoremap <buffer> <F4> :!prove -lv %<CR>
nnoremap <buffer> <F5> :!prove -l %<CR>
setlocal isfname-=-
