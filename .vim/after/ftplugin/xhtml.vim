setlocal tabstop=2     " tab means 4 spaces
setlocal shiftwidth=2  " indent 4 spaces

inoremap <buffer> <Space>, <C-r>=CompleteOpenTag()<CR>
inoremap <buffer> <Space>. </<C-x><C-o>
inoremap <buffer> [[ [% 
inoremap <buffer> [[[ [%- 
inoremap <buffer> ]] %]

function! CompleteOpenTag()
    let col = col('.') - 1
    let chr = getline('.')[col - 1]
    if !col || chr !~ '<'
            return "<\<C-x>\<C-o>"
        else
            return "\<C-x>\<C-o>"
        endif
    endif
endfunction
