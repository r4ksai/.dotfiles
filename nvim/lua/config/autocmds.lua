-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local a = vim.api

-- Turn off paste mode when leaving insert
a.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })

-- -- Fix conceallevel for json files [Already exists in default config]
-- a.nvim_create_autocmd("FileType", {
--   pattern = {
--     "json",
--     "jsonc",
--     "markdown",
--   },
--   callback = function()
--     vim.wo.spell = false
--     vim.wo.conceallevel = 0
--   end,
-- })

-- Save with root permission
a.nvim_create_user_command("W", 'echo "w !sudo tee > /dev/null %"', {})

-- Difference between original file
a.nvim_create_user_command("DiffToOriginal", "w !diff % -", {})

-- Remove trailing whitespaces
a.nvim_create_user_command("RmEndWhitespace", "%s/\\s\\+$//e", {})

-- Highlight on yank [Already exists in default config]
-- local highlight_group = a.nvim_create_augroup("YankHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = "*",
-- })
