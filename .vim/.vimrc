" ----------------------------------------
"  options
" ----------------------------------------
let mapleader = ","
let loaded_matchparen=1

syntax on
filetype plugin indent on

" display options
set cmdheight=1                  " number of lines for command-line height
set expandtab                    " use soft indent
set laststatus=2                 " show status bar always
set lcs=tab:>.,trail:_,extends:+ " show special items
set list
set number
set tabstop=4                    " tab means 4 spaces
set shiftwidth=4                 " indent 4 spaces
set softtabstop=0                " when pressed tab key, provides indent same as 'tabstop'
set wrap

" edit options
set autoindent
set backspace=indent,eol,start
set formatoptions-=o             " not insert comment prefix characters by o/O
set smartindent                  " smart indent on new line
set smarttab                     " at the beggining of line, expanded tab smart operation

" input options
set mouse=a
set ttymouse=xterm

" search behavior
set hlsearch
set ignorecase
set incsearch
set smartcase                    " override 'ignorecase' on search with upper case character
set wrapscan                     " Searches wrap around the end of the file

" completion
set completeopt=menuone,preview

" command-line completion
set wildmenu                     " enhanced command-line completion
set wildmode=list:full           " When more than one match, list all matches and complete first match.

" file operation
set autoread                     " reload file when detect changed at other process
set backup
set backupdir=$HOME/.vimback     " backup dir
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.vimback     " swap file dir
set fileencodings=utf-8,iso-2022-jp,cp932,eucjp-ms


" highlight JpSpace
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
autocmd BufRead,BufNew * match JpSpace /　/

" statusline
set statusline=%y%{GetStatusEx()}%F%m%r%=<%c:%l>
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=cyan
function! GetStatusEx()
    let str = &fileformat . ']'
    if has('multi_byte') && &fileencoding != ''
    let str = '[' . &fileencoding . ':' . str
    endif
    return str
endfunction

" automatical move current directory
augroup BufferAu
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END

" popup menu color schema
highlight Pmenu ctermbg=lightcyan ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray


" ----------------------------------------
"  global key maps
" ----------------------------------------

" tab navigation
nnoremap <tab> :tabn<CR>
nnoremap <S-tab> :tabp<CR>
nnoremap <C-t> :tabnew<CR>

" cursor
nnoremap j gj
nnoremap k gk
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" pbcopy
nnoremap <silent> <Space>y :silent %w !pbcopy<CR><CR> :echo "copied all to clipboard."<CR>
vnoremap <silent> <Space>y :w !pbcopy<CR><CR> :echo "copied selection to clipboard."<CR>

" toggle mode
nnoremap <Space>n :<C-u>setlocal number! \| setlocal number?<CR>
nnoremap <Space>p :<C-u>setlocal paste! \| setlocal paste?<CR>
nnoremap <Space>w :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>e :<C-u>setlocal expandtab! \| setlocal expandtab?<CR>

" completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" etc
nnoremap <Leader><Leader> :<C-u>up<CR>
nnoremap <C-h> :help 
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <F4> :make<CR>
nnoremap <Space>o :<C-u>only<CR>
inoremap <C-k> <C-o>D

" http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
"nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Space>m  :<C-u>marks<CR>
nnoremap <Space>r  :<C-u>registers<CR>
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '/' ? '\?' : '?'


" ----------------------------------------
"  abbreviates
" ----------------------------------------

abbreviate josin join


" ----------------------------------------
"  custom commands
" ----------------------------------------

" http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>

function! ReloadFirefox()
    if has('ruby')
:ruby <<EOF
require 'net/telnet'
telnet = Net::Telnet.new({
    "Host" => "localhost",
    "Port" => 4242
})
telnet.puts("content.location.reload(true)")
telnet.close
EOF
        echo "Reload command was sent to Firefox."
    else
        echo "Ruby is not available."
    endif
endfunction
nnoremap <silent> <Leader>r :<C-u>call ReloadFirefox()<CR>


" ----------------------------------------
"  file types
" ----------------------------------------
augroup MyFileTypes
    autocmd!
    autocmd BufNewFile,BufRead *.psgi setlocal filetype=perl
    autocmd BufNewFile,BufRead *.pp   setlocal filetype=puppet
    autocmd BufNewFile,BufRead *.scss setlocal filetype=css
    autocmd BufNewFile,BufRead *.tt2  setlocal filetype=xhtml
    autocmd BufNewFile,BufRead *.tpl  setlocal filetype=xhtml
    autocmd BufNewFile,BufRead *.mt   setlocal filetype=xhtml
    autocmd BufNewFile,BufRead *.html setlocal filetype=xhtml  " if file type is html, omni complete as upper case
augroup END

augroup Templates
    autocmd!
    autocmd BufNewFile *.pl 0r ~/.vim/template/perl.pl
    autocmd BufNewFile *.pm 0r ~/.vim/template/perl.pm
augroup END

augroup DefineOmniFuncs
    autocmd!
    autocmd FileType ada        setlocal omnifunc=adacomplete#Complete
    autocmd FileType c          setlocal omnifunc=ccomplete#Complete
    autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType java       setlocal omnifunc=javacomplete#Complete
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
    autocmd FileType sql        setlocal omnifunc=sqlcomplete#Complete
    autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
    " default omnifunc.
    autocmd Filetype * if &l:omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
augroup END

" ----------------------------------------
"  plugin settings
" ----------------------------------------

" - neocomplcache ------------------------

" Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
" Use smartcase.
let g:NeoComplCache_SmartCase = 1
" Use previous keyword completion.
let g:NeoComplCache_PreviousKeywordCompletion = 1
" Use tags auto update.
let g:NeoComplCache_TagsAutoUpdate = 1
" Use preview window.
let g:NeoComplCache_EnableInfo = 1
" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Set minimum syntax keyword length.
let g:NeoComplCache_MinSyntaxLength = 2
" Set skip input time.
let g:NeoComplCache_SkipInputTime = '0.2'
" Set manual completion length.
let g:NeoComplCache_ManualCompletionStartLength = 0

" neocomplcache completion
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" normal keyword completion
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"

imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)

" - Align --------------------------------
vnoremap a :Align
vnoremap A :Align => <CR>

" - CamelCaseMotion ----------------------
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
omap <silent> iw <Plug>CamelCaseMotion_iw
vmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
vmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
vmap <silent> ie <Plug>CamelCaseMotion_ie

" - FuzzyFinder --------------------------
nnoremap <silent> <Leader>b :<C-u>FuzzyFinderBuffer<CR>
nnoremap <silent> <Leader>f :<C-u>FuzzyFinderFile<CR>
nnoremap <silent> <Leader>m :<C-u>FuzzyFinderMruFile<CR>
nnoremap <silent> <Leader>c :<C-u>FuzzyFinderMruCmd<CR>
nnoremap <silent> <Leader>d :<C-u>FuzzyFinderDir<CR>

