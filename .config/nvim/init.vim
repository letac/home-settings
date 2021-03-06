set nocompatible
let mapleader = ","
filetype off
filetype plugin indent off

set encoding=utf8
set fileencoding=utf8


" set rtp+=~/.vim/bundle/Vundle.vim

let $NVIM_PYTHON_LOG_FILE="/home/strale/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"

colorscheme jellybeans
call plug#begin('~/.config/nvim/plugged')

Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'jimenezrick/vimerl'
" Plug 'deviantfero/wpgtk.vim'

" nerdtree {{{
" Plug 'scrooloose/nerdtree'
" autocmd vimenter * NERDTree
" }}}

function! MyCoc()
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Use <TAB> to select the popup menu:
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

call MyCoc()

Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'airblade/vim-rooter'

function! MyStartify()
    Plug 'mhinz/vim-startify'
    let g:startify_session_dir = '~/.config/nvim/session'    
    let g:startify_lists = [
                \ { 'type': 'files', 'header': ['   Files']},
                \ { 'type': 'dir', 'header': ['   Current Directory '. getcwd()]},
                \ { 'type': 'sessions', 'header': ['   Sessions']},
                \ { 'type': 'bookmarks', 'header': ['   Bookmarks']}
                \ ]
    let g:startify_bookmarks = [
                \ { 'n': '~/.config/nvim/init.vim' },
                \ { 'b': '~/.config/bspwm/bspwmrc' },
                \ { 's': '~/.config/sxhkd/sxhkdrc' },
                \ ]
endfunction
call MyStartify()

" status bar {{{
Plug 'itchyny/lightline.vim'
set laststatus=2
" }}}

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
" autocmd VimEnter *.rs nested :TagbarOpen
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_width = 25
" }}}

" fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

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
nnoremap <TAB> gt

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" let g:ConqueTerm_TERM='vt100'
" let g:ConqueTerm_ReadUnfocused=1
" autocmd filetype lisp,scheme,art setlocal equalprg=lispindent.lisp

