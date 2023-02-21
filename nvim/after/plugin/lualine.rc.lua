local status, lualine = pcall(require, "lualine")
local wpm_status, wpm = pcall(require, "wpm")

if (not status) then return end

if wpm_status then
    wpm.setup({})
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'dracula',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
        } },
        lualine_x = {
            { 'diagnostics', sources = { "nvim_diagnostic" },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
            'encoding',
            wpm.wpm, wpm.historic_graph,
        },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive' }
}
