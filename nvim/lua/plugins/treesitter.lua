return {
  "nvim-treesitter/nvim-treesitter",
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

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.filetype.add({
      extension = {
        mdx = "mdx",
      },
    })
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
