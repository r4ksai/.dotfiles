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
packadd! dracula
colorscheme dracula
let g:dracula_italic = 0
" set termguicolors
set encoding=UTF-8
set fileencodings=utf-8
set background=dark
syntax enable
set cursorline
set nowrap
set title
set ruler

" Tab completion
" set wildmode=longest,list
set wildmode=longest:list,full

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

" set list
" set listchars=trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂

" History buffer
set history=1000
set hidden

" Persistant Undo
set undofile
set undolevels=1000
set undoreload=10000
set undodir=~/.vim/undo

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
" nnoremap <silent> <esc> :noh<return><esc>

" Finding files - Search down into subfolders
set path+=**

" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**,*/node_modules/*
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv

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

" Remove trailing whitespaces
command! RmEndWhitespace %s/\s\+$//e

" Delete without yank and paste from clipbaord 0
noremap <leader>d "_d
noremap <leader>p "_dP
noremap x "_x
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

"-----------------------------
" Langauge Specific

" Python
if executable('yapf') == 1
    command! PyFormat 0,$!yapf
endif

" autocmd FileType python set shiftwidth=2
" autocmd FileType python set tabstop=2
" autocmd FileType python set softtabstop=2

"-----------------------------
" tabs

" Open current directory
nmap te :tabedit 
nmap to <C-w>T
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Resize window
nmap s<left> <C-w><
nmap s<right> <C-w>>
nmap s<up> <C-w>+
nmap s<down> <C-w>-
" Maximize window
map sm <C-w>_
map se <C-w>=

"------------------------------
" plugins

    call plug#begin('~/.vim/plugged')

    " Syntax checking
    " ale requires additional linting packages eg flake8 for python
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'

    " Autocompletion
    Plug 'jiangmiao/auto-pairs'
    Plug 'mattn/emmet-vim'

    " File Browser
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    " Langauge
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'

    Plug 'othree/html5.vim'

    " Theme
    Plug 'bling/vim-airline'


" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Themes
Plug 'ap/vim-css-color'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'

" Commenting
Plug 'tpope/vim-commentary'

" Extras
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()

"------------------------------
" Plugin settings

" Activate rainbow plugin
let g:rainbow_active = 1
" Open/Close undotree
nnoremap <leader>m :UndotreeToggle<CR>:UndotreeFocus<CR>

    " Open/Close nerdtree
    nnoremap <leader>n :NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen = 1

    " FzF Keymaps
    noremap <leader>f :Files<CR>
    noremap <leader>g :GFiles<CR>
    noremap <leader>b :Buffers<CR>
    nnoremap <leader>s :Rg<CR>

    " FzF Layout
    let g:fzf_preview_window = 'right:50%'
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

    let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    let g:fzf_buffers_jump = 1
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    " Airline theme
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts=1
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline_section_z = airline#section#create('%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# %3v')

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

" Install coc-typeserver coc-json coc-jedi
" Pip install jedi
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

let g:coc_global_extensions = [
            \'coc-json',
            \'coc-tsserver',
            \'coc-jedi',
            \]

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Pettier
" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument " Manual
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
