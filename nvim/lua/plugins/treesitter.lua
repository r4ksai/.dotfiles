return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {

      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",

      "tsx",
      "javascript",
      "typescript",
      "query",
      "css",
      "html",
      "astro",
      "http",
      "scss",
      "svelte",

      "bash",
      "regex",
      "vim",
      "vimdoc",

      "lua",
      "python",

      "sql",
      "gitignore",
      "dockerfile",
      -- "dart",

      "cmake",
      "make",
      "arduino",
      "c",
      "cpp",
    })
    opts.folds = { enable = true }
    opts.highlight = {
      enable = true,
      use_languagetree = true,
      disable = {},
    }
    opts.indent = {
      enable = true,
      disable = {},
    }
  end,
}
