local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
    defaults = {
        file_ignore_patterns = { ".git/" },
        mappings = {
            n = {
                ["q"] = actions.close
            },
        },
    },
    extensions = {
        file_browser = {
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                -- your custom normal mode mappings
                ["n"] = {
                    ["N"] = fb_actions.create,
                    ["h"] = fb_actions.goto_parent_dir,
                },
            },
        },
    },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>f',
    function()
        builtin.find_files({
            no_ignore = false,
            hidden = true,
        })
    end, { desc = '[F]ile Search' })
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = '[S]earch word' })
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Recently opened files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[B]uffers' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[H]elp' })
vim.keymap.set('n', '<leader>?', builtin.resume, { desc = '[?] Resume last search' })
vim.keymap.set('n', '<leader>e', builtin.diagnostics, { desc = '[E]rros and diagnostics' })
vim.keymap.set('n', '<leader>k', builtin.keymaps, { desc = '[K]eymaps' })
-- vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[G]oto [R]erefences' })
vim.keymap.set('n', '<leader><space>', builtin.lsp_document_symbols, { desc = '[ ] Show Symbols' })
vim.keymap.set('n', '<leader>g', builtin.git_commits, { desc = '[G]it Status' })
vim.keymap.set('n', 'sf', function()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = 'normal',
        layout_config = { height = 40 }
    })
end, { desc = '[S]how [F]iles' })
