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
set encoding=UTF-8
packadd! dracula
colorscheme dracula
let g:dracula_italic = 0
set background=dark
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

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Autocompletion
set wildmenu

" Good for performance
set lazyredraw

" Save with root permission
command! W w !sudo tee > /dev/null %

" Delete without yank and paste from clipbaord 0
nnoremap <leader>d "_d
nnoremap x "_x
nnoremap <S-C-p> "0p

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Select all
nmap <C-a> gg<S-v>G

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
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

let g:rainbow_active = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = airline#section#create('%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# %3v')

map <F5> :NERDTreeToggle<CR>
