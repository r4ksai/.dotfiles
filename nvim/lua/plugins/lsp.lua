return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "luacheck",
        "selene",
        "shellcheck",
        "shfmt",
        "flake8",
        "css-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svls = {
          -- svls (and the svlint it embeds) looks for .svlint.toml in the
          -- process's cwd, not the LSP root_dir, so left alone it always
          -- spawns with *this* cwd and reports "not found, enable all
          -- rules" unless nvim happened to be launched from the right
          -- directory. Resolve a proper root (project config/.git, else
          -- the shared ~/.config/svls, symlinked from dotfiles/svls) and
          -- launch svls with that as its actual working directory.
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = vim.fs.root(fname, { ".svlint.toml", ".svls.toml", ".git" })
            on_dir(root or vim.fn.expand("~/.config/svls"))
          end,
          cmd = function(dispatchers, config)
            return vim.lsp.rpc.start({ "svls" }, dispatchers, { cwd = config.root_dir })
          end,
        },
      },
    },
  },
}
