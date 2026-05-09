local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "s", "<Nop>")
keymap.set("n", "S", "<Nop>")

-- Delete without yank / paste from yank register
keymap.set("n", "x", '"_x', { desc = "Delete character without copy" })
keymap.set("v", "<leader><leader>p", '"0p', { desc = "Paste without copy" })
keymap.set("n", "<leader><leader>p", '"0p', { desc = "Paste without copy" })
keymap.set("n", "<leader><leader>P", '"0P', { desc = "Paste without copy" })

keymap.set("n", "<leader><leader>c", '"_c', { desc = "Cut without copy" })
keymap.set("n", "<leader><leader>C", '"_C', { desc = "Cut without copy" })
keymap.set("v", "<leader><leader>c", '"_c', { desc = "Cut without copy" })
keymap.set("v", "<leader><leader>C", '"_C', { desc = "Cut without copy" })

keymap.set("n", "<leader><leader>d", '"_d', { desc = "Delete without copy" })
keymap.set("n", "<leader><leader>D", '"_D', { desc = "Delete without copy" })
keymap.set("v", "<leader><leader>d", '"_d', { desc = "Delete without copy" })
keymap.set("v", "<leader><leader>D", '"_D', { desc = "Delete without copy" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number under cursor" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number under cursor" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Tabs
keymap.set("n", "te", ":tabedit ", { desc = "Tab edit", noremap = true, silent = true })
keymap.set("n", "<tab>", ":tabnext<Return>", { desc = "Tab next", noremap = true, silent = true })
keymap.set("n", "<s-tab>", ":tabprev<Return>", { desc = "Tab prev", noremap = true, silent = true })
keymap.set("n", "to", "<C-w>T", { desc = "Open split in new tab", noremap = true, silent = true })

-- Splits
keymap.set("n", "ss", ":split<Return>", { desc = "Split horizontal", noremap = true, silent = true })
keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split vertical", noremap = true, silent = true })
keymap.set("n", "<Space>", "<C-w>w", { desc = "Jump between splits" })
keymap.set("n", "sh", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "sk", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "sj", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "sl", "<C-w>l", { desc = "Move to right split" })
keymap.set("n", "se", "<C-w>=", { desc = "Equalize splits" })

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- LSP (set on attach — see plugins/lsp.lua)
