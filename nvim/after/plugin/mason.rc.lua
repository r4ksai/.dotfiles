local mason_status, mason = pcall(require, "mason")
if (not mason_status) then return end

local mason_lspconfig_status, lspconfig = pcall(require, "mason-lspconfig")
if (not mason_lspconfig_status) then return end

mason.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
}

lspconfig.setup {
    automatic_installation = true
}

-- lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }
