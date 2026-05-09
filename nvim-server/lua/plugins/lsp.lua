local function on_attach(_, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  map("gd", vim.lsp.buf.definition, "Go to definition")
  map("gD", vim.lsp.buf.declaration, "Go to declaration")
  map("gr", vim.lsp.buf.references, "References")
  map("gi", vim.lsp.buf.implementation, "Go to implementation")
  map("K", vim.lsp.buf.hover, "Hover docs")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")
  map("<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
end

return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",        -- bash
          "pyright",       -- python
          "dockerls",      -- dockerfile
          "docker_compose_language_service", -- docker-compose
          "yamlls",        -- yaml
          "lua_ls",        -- lua (for editing this config)
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        bashls = {},
        pyright = {},
        dockerls = {},
        docker_compose_language_service = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end,
  },
}
