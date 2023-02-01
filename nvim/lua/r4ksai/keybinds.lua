local g = vim.g
local keymap = vim.keymap

-- Leader
g.mapleader = ';'

-- Delete without yank and paste from clipbaord 0
keymap.set('n', 'x', '"_x', { desc = "Delete character without copy" })
keymap.set('n', '<leader>d', '"_d', { desc = "Delete without copy" })
keymap.set('n', '<leader>p', '"_dP', { desc = "Paste without copy" })

-- Increment/decrement
keymap.set('n', '+', '<C-a>', { desc = "Incremnt number under the cursor" })
keymap.set('n', '-', '<C-x>', { desc = "Decrement number under the cursor" })

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v><S-g>', { desc = "Select all" })

-- New Tab
keymap.set('n', 'te', ':tabedit', { desc = "[T]ab [E]dit" })

-- New Tab from current buffer
keymap.set('n', 'to', '<C-w>T', { desc = "[T]ab [O]pen current split" })

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', { desc = "[S]plit Horizontal" })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { desc = "[S]plit [V]ertical" })

-- Move window
keymap.set('n', '<Space>', '<C-w>w', { desc = "Jump between splits" })
keymap.set('', 'sh', '<C-w>h', { desc = "Move to the left split" })
keymap.set('', 'sk', '<C-w>k', { desc = "Move to the top split" })
keymap.set('', 'sj', '<C-w>j', { desc = "Move to the bottom split" })
keymap.set('', 'sl', '<C-w>l', { desc = "Move to the right split" })

-- Resize window
-- keymap.set('n', 's<left>', '<C-w><')
-- keymap.set('n', 's<right>', '<C-w>>')
-- keymap.set('n', 's<up>', '<C-w>+')
-- keymap.set('n', 's<down>', '<C-w>-')

-- Maximize window
-- keymap.set('n', 'sm', '<C-w>_')
keymap.set('n', 'se', '<C-w>=')
