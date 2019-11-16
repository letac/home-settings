set nocompatible
let mapleader = ","
filetype off
filetype plugin indent off

set encoding=utf8
set fileencoding=utf8


" set rtp+=~/.vim/bundle/Vundle.vim

let $NVIM_PYTHON_LOG_FILE="/home/strale/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"


call plug#begin('~/.config/nvim/plugged')

Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'jimenezrick/vimerl'
Plug 'deviantfero/wpgtk.vim'

" nerdtree {{{
" Plug 'scrooloose/nerdtree'
" autocmd vimenter * NERDTree
" }}}

function! MyCoc()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Use <TAB> to select the popup menu:
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

call MyCoc()

Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'airblade/vim-rooter'

" status bar {{{
Plug 'itchyny/lightline.vim'
set laststatus=2
" }}}

function! MyAle()
    Plug 'w0rp/ale'

    let g:ale_linters = { 'rust': ['rls', 'cargo']}
    let g:ale_rust_cargo_check_all_targets = 0
    let g:ale_rust_cargo_check_tests = 0
    let g:ale_virtualtext_cursor = 1
    let g:ale_rust_rls_config = {
        \ 'rust': {
            \ 'all_targets': 1,
            \ 'build_on_save': 1,
            \ 'clippy_preference': 'on'
        \ }
    \}
    let g:ale_open_list = 1

    highlight link ALEWarningSign Todo
    highlight link ALEErrorSign WarningMsg
    highlight link ALEVirtualTextWarning Todo
    highlight link ALEVirtualTextInfo Todo
    highlight link ALEVirtualTextError WarningMsg
    highlight ALEError guibg=None
    highlight ALEWarning guibg=None
    let g:ale_sign_error = "✖"
    let g:ale_sign_warning = "⚠"
    let g:ale_sign_info = "i"
    let g:ale_sign_hint = "➤" 
endfunction
call MyAle()

" rust {{{
Plug 'rust-lang/rust.vim'
" Plug 'racer-rust/vim-racer'
"Plug 'timonv/vim-cargo'

let g:rustfmt_autosave = 1

"let g:racer_experimental_completer = 1
" }}}

" nix {{{
Plug 'LnL7/vim-nix'
" }}}

" tagbar {{{
Plug 'majutsushi/tagbar'
autocmd VimEnter *.rs nested :TagbarOpen
" }}}

" fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

" Plug 'ervandew/supertab'

function! MyDeoplete()
    Plug 'roxma/nvim-yarp'
    if has('nvim')
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/deoplete.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup = 1
endfunction

function! MyNcm2()
    Plug 'ncm2/ncm2'
    " Plug 'ncm2/ncm2-racer'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    autocmd BufEnter * call ncm2#enable_for_buffer()
endfunction

call plug#end()
filetype plugin indent on

let g:netrw_banner=0
let g:netrw_liststyle=3


if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

function! MySearch()
    set incsearch
    set ignorecase
    set smartcase
    set hidden
endfunction
call MySearch()

function! MyIndenting()
    set cindent
    set smartindent
    set autoindent
    set expandtab " pretvara tab u pauze
    set linebreak
    set tabstop=8
    set shiftwidth=4
endfunction
call MyIndenting()

set ruler
set cursorline
set number relativenumber

" set autochdir

" backupdir
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.

" colorcsheme zenburn cak i za terminal nije toliko lica
" :colorscheme wpgtk

" spellcheck
" set spell spelllang=en_us

" clipboard settings
set clipboard=unnamedplus

function! MyFold()
    set foldcolumn=3
    set nofoldenable
    nnoremap <space> za
endfunction

set path+=**
" set wildmenu

set enc=utf-8
set tags+=$HOME/.vim/tags/cpp 

" haskell
" let g:haddock_browser="/usr/bin/firefox"
" au BufEnter *.hs compiler ghc

" strelice su isljucene
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" hl isljucen
"nnoremap h <NOP>
"nnoremap l <NOP>

" cuvanje pogleda

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

" izlazenje iz insert moda sa jk
inoremap hg <Esc>
inoremap kj <Esc>

" tabs
nnoremap <Tab> gt

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" let g:ConqueTerm_TERM='vt100'
" let g:ConqueTerm_ReadUnfocused=1
" autocmd filetype lisp,scheme,art setlocal equalprg=lispindent.lisp

