local status, todo = pcall(require, "todo-comments")
if (not status) then return end

todo.setup {

}

vim.keymap.set("n", "]t", function()
    todo.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    todo.jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "<leader>t", ":TodoTelescope<CR>", { desc = "Todo list" })
