-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"
vim.g.autoformat = true
vim.g.snacks_animate = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.markdown_recommended_style = 0

-- Colors / display
opt.termguicolors = true
opt.encoding = "UTF-8"
opt.fileencodings = "UTF-8"
opt.background = "dark"
opt.cursorline = true
opt.wrap = false
opt.title = true
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.list = true
opt.showmode = false
opt.pumblend = 10
opt.pumheight = 10
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Bells
opt.errorbells = false
opt.visualbell = false

-- Indent / tabs
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true
opt.expandtab = true
opt.breakindent = true

-- History / undo
opt.history = 1000
opt.hidden = true
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- File finding
opt.path:append({ "**" })
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe" })
opt.wildignore:append({ "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**", "*/node_modules/*" })
opt.wildignore:append({ "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico" })
opt.wildignore:append({ "*.pyc", "*.pkl" })
opt.wildignore:append({ "*.DS_Store" })
opt.wildignore:append({ "*.aux", "*.bbl", "*.blg", "*.brf", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.xdv" })

-- Pairs
opt.mps:append({ "<:>" })

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Format
opt.formatoptions = "jcroqlnt"

-- Scroll context
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Backup
opt.backup = false
opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Clipboard / shell
opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.shell = "zsh"
opt.backspace = { "indent", "eol", "start" }

-- Command line
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 3
opt.inccommand = "nosplit"

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true

-- Session / timing
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.timeoutlen = 300
opt.updatetime = 200

-- Mouse (disabled)
opt.mouse = ""

-- Misc
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.virtualedit = "block"
opt.winminwidth = 5

-- Folding
opt.foldmethod = "marker"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
