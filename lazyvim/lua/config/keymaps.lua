-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local discipline = require("r4ksai.discipline")
-- discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete without yank and paste from clipboard 0
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

keymap.set("n", "<leader>i", function()
  require("r4ksai.lsp").toggleInlayHints()
end)
