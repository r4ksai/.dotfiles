local a = vim.api
-- Don't load if the file is small
-- if !1 | finish | endif

-- Turn off paste mode when leaving insert
a.nvim_create_autocmd('InsertLeave', { command = "lua vim.o.paste = false" })

-- Save with root permission
a.nvim_create_user_command('W', 'echo "w !sudo tee > /dev/null %"', {})
-- Difference between original file
a.nvim_create_user_command('DiffToOriginal', 'w !diff % -', {})
-- Remove trailing whitespaces
a.nvim_create_user_command('RmEndWhitespace', '%s/\\s\\+$//e', {})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
