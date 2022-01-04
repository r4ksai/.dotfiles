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

" Don't load if the file is small
if !1 | finish | endif

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
set undolevels=1000
set undoreload=10000
if has ("nvim")
    set undodir=~/.config/nvim/undo
else
    set undodir=~/.vim/undo
endif

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*
set wildignore+=*/.git/*
set wildignore+=*/__pycache__/*

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

" Difference between original file
command! DiffO w !diff % - 

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
" Langauge Specific

" Python
if executable('yapf') == 1
    if &filetype == 'python'
        command! PyFormat 0,%!yapf
    endif
endif

" autocmd FileType python set shiftwidth=2
" autocmd FileType python set tabstop=2
" autocmd FileType python set softtabstop=2

"-----------------------------
" tabs

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
" plugins

if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
    call plug#begin()

    " Themes
    Plug 'dracula/vim', { 'as': 'dracula' }

    " Autocompletion
    Plug 'github/copilot.vim'
else
    call plug#begin('~/.vim/plugged')
endif

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntax checking 
" ale requires additional linting packages eg flake8 for python
Plug 'dense-analysis/ale' 

" Autocompletion
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

" Themes
Plug 'bling/vim-airline'
Plug 'ap/vim-css-color'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'

" Commenting
Plug 'tpope/vim-commentary'

" File Browser
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Extras
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()

"------------------------------
" Plugin settings

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
let NERDTreeQuitOnOpen = 1

" Nerdtree UI
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'

" Open/Close undotree
nnoremap <leader>m :UndotreeToggle<CR>

" FzF Keymaps
noremap <leader>f :Files<CR>
noremap <leader>g :GFiles<CR>
noremap <leader>b :Buffers<CR>
nnoremap <leader>s :Rg<CR>

" FzF Layout
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

" Ale UI
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Important keybindings to remember
" ---------------------------------
"
" ss & sv -> Split 
" te -> Tab
" tab -> Move between tabs
" Control + n -> Auto Suggestion 
" gcc -> Comment
" Control + y + , -> Emmet
" leader + m -> toggle Undotree
" leader + n -> toggle Nerdtree
" ysWf<function_name> -> Create a function around a string
