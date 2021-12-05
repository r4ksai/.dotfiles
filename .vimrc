""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Depreciated
set nocompatible
filetype off

" Theme
packadd! dracula
colorscheme dracula
syntax enable
set cursorline
set nowrap
set title

" Highlight opening and closing brackets
set showmatch
set mps+=<:> 

" Folding
set foldmethod=marker foldlevel=0
set nofoldenable

" Show numbers
set number
set relativenumber

" Errors
set noerrorbells
set visualbell

" Indent
set autoindent 
set smarttab
set tabstop=4
set shiftwidth=4

" History buffer
set history=1000

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Autocompletion
set wildmenu

" Good for performance
set lazyredraw

" Save with root permission
command! W w !sudo tee > /dev/null %

" Others
set clipboard=unnamed
set shell=zsh
set backspace=indent,eol,start

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit 
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

"------------------------------
" Plugins

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'

" Initialize plugin system
call plug#end()
