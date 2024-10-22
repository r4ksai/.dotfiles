return {
  "nvim-treesitter/nvim-treesitter",
  -- dependencies = {
  --   "p00f/nvim-ts-rainbow",
  --   "windwp/nvim-ts-autotag",
  -- },
  opts = {
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = {},
    },
    indent = {
      enable = true,
      disable = {},
    },
    ensure_installed = {

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
    },
    -- autotag = {
    --   enable = true,
    -- },
    -- rainbow = {
    --   enable = true,
    --   extended_mode = true,
    --   max_file_lines = nil,
    -- },
  },
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
