" pretraga
set incsearch
set ignorecase
set smartcase
set hidden
" identacija
set cindent
set smartindent
set autoindent

set expandtab " pretvara tab u pauze
filetype plugin on
set linebreak
set tabstop=4
set shiftwidth=4
set number
set autochdir

"fold zafrkancije
set foldmethod=syntax
set foldcolumn=3
nnoremap <space> za

set enc=utf-8
set tags+=$HOME/.vim/tags/cpp 

" haskell
let g:haddock_browser="/usr/bin/firefox"
" au BufEnter *.hs compiler ghc

" strelice su isljucene
" inoremap <Left> <NOP>
" inoremap <Right> <NOP>
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>

" ubacivanje jednog karaktera
:nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
:nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" izlazenje iz insert moda sa jk
inoremap kj <Esc>

let g:ConqueTerm_TERM='vt100'
let g:ConqueTerm_ReadUnfocused=1
autocmd filetype lisp,scheme,art setlocal equalprg=lispindent.lisp
