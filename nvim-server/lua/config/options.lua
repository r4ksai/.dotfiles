local opt = vim.opt

vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"
vim.g.markdown_recommended_style = 0

-- Colors / display
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showmode = false
opt.list = true
opt.fillchars = { eob = " ", diff = "╱" }

-- Indent
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true
opt.expandtab = true

-- History / undo
opt.history = 1000
opt.hidden = true
opt.undofile = true
opt.undolevels = 1000

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Scroll context
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Backup
opt.backup = false

-- Clipboard / shell
opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.shell = "zsh"

-- Command line
opt.laststatus = 3
opt.cmdheight = 1
opt.inccommand = "nosplit"
opt.confirm = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Timing
opt.timeoutlen = 300
opt.updatetime = 200

-- Mouse (disabled)
opt.mouse = ""

-- Misc
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.spelllang = { "en" }
opt.virtualedit = "block"
opt.winminwidth = 5
opt.formatoptions = "jcroqlnt"

-- Folding
opt.foldmethod = "marker"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
