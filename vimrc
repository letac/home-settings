set nocompatible
let mapleader = ","

" vindle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'scala/scala-dist', {'rtp': 'tool-support/src/vim'}
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jimenezrick/vimerl'

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

" colorcsheme zenburn cak i za terminal nije toliko lica
:colorscheme zenburn

" spellcheck
" set spell

" clipboard settings
set clipboard=unnamedplus

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
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" hl isljucen
"nnoremap h <NOP>
"nnoremap l <NOP>

" function keys mapings
nnoremap <F5> :GundoToggle<CR>

" ubacivanje jednog karaktera
:nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
:nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" cuvanje pogleda

au BufWinLeave * mkview
au BufWinEnter * silent loadview

" izlazenje iz insert moda sa jk
inoremap hg <Esc>
inoremap kj <Esc>

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

let g:ConqueTerm_TERM='vt100'
let g:ConqueTerm_ReadUnfocused=1
autocmd filetype lisp,scheme,art setlocal equalprg=lispindent.lisp
