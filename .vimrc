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
if !has("nvim")
    packadd! dracula
    colorscheme dracula
    let g:dracula_italic = 0
endif
set encoding=UTF-8
set fileencodings=utf-8
set background=dark
syntax enable
set cursorline
set nowrap
set title

" Leader
let mapleader=';'

" Highlight opening and closing brackets
set showmatch
set mps+=<:> 

" Folding
set foldmethod=marker foldlevel=0
set foldenable

" Show numbers
set number
set relativenumber

" Errors
set noerrorbells
set visualbell

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

" Indent
filetype plugin indent on
set autoindent 
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" History buffer
set history=1000
set hidden

" Persistant Undo
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*
set wildignore+=*/.git/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Autocompletion
set wildmenu

" Add asterisks in block comments
set formatoptions+=r

" Good for performance
set lazyredraw
set scrolloff=10

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

" Backup
set nobackup
set backupskip=/tmp/*,/private/tmp/*

" Others
set clipboard=unnamed
set shell=zsh
set backspace=indent,eol,start

set showcmd
set cmdheight=1
set laststatus=2

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

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

if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
    call plug#begin()
    Plug 'dracula/vim', { 'as': 'dracula' }
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'bling/vim-airline'
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

if has("nvim")
    " Theme 
    colorscheme dracula
endif

" Activate rainbow plugin
let g:rainbow_active = 1

" Airline theme
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = airline#section#create('%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# %3v')

" Open/Close nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" Open/Close undotree
nnoremap <leader>m :UndotreeToggle<CR>

" Important keybindings to remember
" ---------------------------------
" ss & sv -> Split 
" te -> Tab
" tab -> Move between tabs
" Control + n -> Auto Suggestion 
" gcc -> Comment
" Control + y + , -> Emmet
" Enter -> toggle Undotree
" Control + n in normal mode -> toggle Nerdtree
