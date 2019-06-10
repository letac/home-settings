set nocompatible
let mapleader = ","
filetype off
filetype plugin indent off

set encoding=utf-8
set fileencoding=utf-8


" set rtp+=~/.vim/bundle/Vundle.vim

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
call plug#begin('~/.config/nvim/plugged')

Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'jimenezrick/vimerl'
Plug 'deviantfero/wpgtk.vim'
" Plugin 'scrooloose/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'airblade/vim-rooter'

Plug 'itchyny/lightline.vim'

" ale {{{
Plug 'w0rp/ale'

let g:ale_linters = { 'rust': ['rls', 'cargo']}
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1

" }}}

" rust {{{
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'timonv/vim-cargo'

let g:rustfmt_autosave = 1

let g:racer_cmd = "/home/strale/.cargo/bin/racer"
let g:racer_experimental_completer = 1
" }}}

" Plugin 'majutsushi/tagbar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'ervandew/supertab'

Plug 'roxma/nvim-yarp'
 " if has('nvim')
   " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 " else
   " Plug 'Shougo/deoplete.nvim'
   " Plug 'roxma/nvim-yarp'
   " Plug 'roxma/vim-hug-neovim-rpc'
 " endif

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

" ncm2 {{{

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

call plug#end()
filetype plugin indent on

 " let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('smart_case', v:true)

" Plug 'scala/scala-dist', {'rtp': 'tool-support/src/vim'}


set laststatus=2

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

" let g:SuperTabDefaultCompletionType = "context"

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
autocmd BufWritePost *.rs :silent! exec "make check" | redraw!

let g:netrw_banner=0
let g:netrw_liststyle=3

" let NERDTreeShowHidden=1

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
set linebreak
set tabstop=4
set shiftwidth=4

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

"clang-format
" map <C-I> :py3f ~/bin/clang-format.py<cr>
" imap <C-I> <c-o>:py3f ~/bin/clang-format.py<cr>

"fold zafrkancije
set foldmethod=syntax
set foldcolumn=3
set nofoldenable
nnoremap <space> za

set path+=**
set wildmenu

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

" function keys mapings
" nnoremap <F5> :GundoToggle<CR>

" ubacivanje jednog karaktera
":nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
":nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" cuvanje pogleda

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

" izlazenje iz insert moda sa jk
inoremap hg <Esc>
inoremap kj <Esc>

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" let g:ConqueTerm_TERM='vt100'
" let g:ConqueTerm_ReadUnfocused=1
" autocmd filetype lisp,scheme,art setlocal equalprg=lispindent.lisp

