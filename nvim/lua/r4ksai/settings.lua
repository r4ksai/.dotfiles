local o = vim.o
local O = vim.opt

-- Depreciated
o.compatible = false
o.filetype = false

o.termguicolors = true
o.encoding = 'UTF-8'
o.fileencodings = 'UTF-8'
o.background = 'dark'
o.syntax = true
o.cursorline = true
o.wrap = false
o.title = true
o.ruler = true
o.mouse = false

-- Tab completion
o.wildmenu = true
o.wildmode='longest:list,full'

-- Show characters
-- o.list = true
-- o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'


-- Highlight opening and closing brackets
o.match = true
O.mps:append {'<:>'}

-- Folding
o.foldmethod = 'marker'
o.foldlevel = 0
o.fold = true

-- Show numbers
o.number = true
o.relativenumber = true

-- Errors
o.errorbells = false
o.visualbell = false

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
o.t_BE = ''

-- Indent
-- filetype plugin indent on
o.autoindent = true
o.smarttab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-- History buffer
o.history = 1000
o.hidden = true

-- Persistant Undo
o.undofile = true
o.undolevels = 1000
o.undoreload = 10000
-- ~ not expanding 
-- O.undodir = '~/.config/nvim/undo'
-- o.undodir = vim.fn.expand('~/.config/nvim/undo')

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Finding files - Search down into subfolders
O.path:append {'**'}

-- Ignore certain files and folders when globing
O.wildignore:append {'*.o','*.obj','*.dylib','*.bin','*.dll','*.exe'}
O.wildignore:append {'*/.git/*','*/.svn/*','*/__pycache__/*','*/build/**','*/node_modules/*'}
O.wildignore:append {'*.jpg','*.png','*.jpeg','*.bmp','*.gif','*.tiff','*.svg','*.ico'}
O.wildignore:append {'*.pyc','*.pkl'}
O.wildignore:append {'*.DS_Store'}
O.wildignore:append {'*.aux','*.bbl','*.blg','*.brf','*.fls','*.fdb_latexmk','*.synctex.gz','*.xdv'}

-- Add asterisks in block comments
O.formatoptions:append {'r'}

-- Good for performance
o.lazyredraw = true
o.scrolloff = 10

-- Backup
o.backup = false
O.backupskip = {'/tmp/*', '/private/tmp/*'}

-- Others
o.clipboard = 'unnamed'
o.shell = 'zsh'
O.backspace = {'indent', 'eol', 'start'}

o.showcmd = true
o.cmdheight = 1
o.laststatus = 2

-- incremental substitution
o.inccommand = 'split'
