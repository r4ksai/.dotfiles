return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "python", "dockerfile", "yaml", "json", "toml",
          "lua", "vim", "vimdoc", "markdown", "markdown_inline",
          "regex", "gitignore", "make", "ini",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
