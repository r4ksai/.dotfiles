-- Options are automatically loaded before lazy.nvim startup
--
local opt = vim.opt

-- This file is automatically loaded by plugins.core
vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

-- Enable LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

opt.compatible = false

opt.termguicolors = true
opt.encoding = "UTF-8"
opt.fileencodings = "UTF-8"
opt.background = "dark"

opt.cursorline = true
opt.wrap = false
opt.title = true
opt.ruler = true
opt.mouse = ""

opt.wildmenu = true

-- vim.o.match = true
opt.mps:append({ "<:>" })

-- Show numbers
opt.number = true
opt.relativenumber = true

-- Errors
opt.errorbells = false
opt.visualbell = false

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
-- vim.o.t_BE = ""

-- Indent
-- filetype plugin indent on
opt.autoindent = true
opt.smarttab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.breakindent = true

-- History buffer
opt.history = 1000
opt.hidden = true

-- Persistent Undo
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
-- ~ not expanding
-- opt.undodir = '~/.config/nvim/undo'
-- opt.undodir = vim.fn.expand('~/.config/nvim/undo')

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Finding files - Search down into subfolders
opt.path:append({ "**" })

-- Ignore certain files and folders when globing
opt.wildignore:append({ "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe" })
opt.wildignore:append({ "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**", "*/node_modules/*" })
opt.wildignore:append({ "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico" })
opt.wildignore:append({ "*.pyc", "*.pkl" })
opt.wildignore:append({ "*.DS_Store" })
opt.wildignore:append({ "*.aux", "*.bbl", "*.blg", "*.brf", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.xdv" })

-- Add asterisks in block comments
opt.formatoptions:remove({ "c", "r", "o" })

-- Good for performance
opt.scrolloff = 10

-- Backup
opt.backup = false
opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Others
opt.clipboard = "unnamed"
opt.shell = "zsh"
opt.backspace = { "indent", "eol", "start" }

opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2

-- incremental substitution
opt.inccommand = "split"

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Folding
opt.foldmethod = "marker"
opt.foldlevel = 0
opt.foldenable = true
-- vim.op.fold = true
-- vim.o.file = true

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
