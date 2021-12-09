
" Depreciated
set nocompatible
filetype off

" Theme
set encoding=UTF-8
set fileencodings=utf-8
" packadd! dracula
" colorscheme dracula
" let g:dracula_italic = 0
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

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

" Indent
filetype plugin indent on
set autoindent 
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

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

runtime ./maps.vim
