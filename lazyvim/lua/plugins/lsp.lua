return {
  "williamboman/mason.nvim",
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
}
