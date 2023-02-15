local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

null_ls.setup {
    sources = {
        -- null_ls.builtins.formatting.clang_format, -- C, C++ Formatting
        null_ls.builtins.formatting.black.with { extra_args = { "--fast" } }, -- Python Formatting
        null_ls.builtins.formatting.isort, -- Python Sorting
        null_ls.builtins.diagnostics.flake8.with { extra_args = { "--ignore=E501,W503,W504" } }, -- Python Formatting
        null_ls.builtins.formatting.prettierd, -- HTML, CSS, etc Formatting
        null_ls.builtins.diagnostics.eslint.with({ -- JS Diagnostics
            diagnostics_format = '[eslint] #{m}\n(#{c})'
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end
}

vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
