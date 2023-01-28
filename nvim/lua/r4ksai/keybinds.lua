local g = vim.g
local keymap = vim.keymap

-- Leader
g.mapleader = ';'

-- Delete without yank and paste from clipbaord 0
keymap.set('n', 'x', '"_x')
keymap.set('n', '<leader>d', '"_d')
keymap.set('n', '<leader>p', '"_dP')
keymap.set('n', '<S-C-p>p', '"0p')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>g')

-- New Tab
keymap.set('n', 'te', ':tabedit')

-- New Tab from current buffer
keymap.set('n', 'to', '<C-w>T')

-- Tab Jumping (Moved to BufferLine)
-- keymap.set('n', '<S-Tab>', ':tabprev<Return>')
-- keymap.set('n', '<Tab>', ':tabnext<Return>')

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', 's<left>', '<C-w><')
keymap.set('n', 's<right>', '<C-w>>')
keymap.set('n', 's<up>', '<C-w>+')
keymap.set('n', 's<down>', '<C-w>-')

-- Maximize window
keymap.set('n', 'sm', '<C-w>_')
keymap.set('n', 'se', '<C-w>=')
