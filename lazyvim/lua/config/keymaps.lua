-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

keymap.set("n", "x", '"_x', { desc = "Delete character without copy" })

-- Delete without yank and paste from clipbaord 0
keymap.set("n", "<leader>d", '"_d', { desc = "Delete without copy" })
keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without copy" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Incremnt number under the cursor" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number under the cursor" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v><S-g>", { desc = "Select all" })

-- New Tab
keymap.set("n", "te", ":tabedit ", { desc = "[T]ab [E]dit", noremap = true, silent = true })
keymap.set("n", "<tab>", ":tabnext<Return>", { desc = "[T]ab Next", noremap = true, silent = true })
keymap.set("n", "<s-tab>", ":tabprev<Return>", { desc = "[T]ab Previous", noremap = true, silent = true })

-- New Tab from current buffer
keymap.set("n", "to", "<C-w>T", { desc = "[T]ab [O]pen current split", noremap = true, silent = true })

-- Split window
keymap.set("n", "ss", ":split<Return>", { desc = "[S]plit Horizontal", noremap = true, silent = true })
keymap.set("n", "sv", ":vsplit<Return>", { desc = "[S]plit [V]ertical", noremap = true, silent = true })

-- Move window
keymap.set("n", "<Space>", "<C-w>w", { desc = "Jump between splits" })
keymap.set("n", "sh", "<C-w>h", { desc = "Move to the left split" })
keymap.set("n", "sk", "<C-w>k", { desc = "Move to the top split" })
keymap.set("n", "sj", "<C-w>j", { desc = "Move to the bottom split" })
keymap.set("n", "sl", "<C-w>l", { desc = "Move to the right split" })

-- Resize window
-- keymap.set('n', 's<left>', '<C-w><')
-- keymap.set('n', 's<right>', '<C-w>>')
-- keymap.set('n', 's<up>', '<C-w>+')
-- keymap.set('n', 's<down>', '<C-w>-')

-- Maximize window
-- keymap.set('n', 'sm', '<C-w>_')
keymap.set("n", "se", "<C-w>=")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)
