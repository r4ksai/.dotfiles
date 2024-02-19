return {
  {
    "mbbill/undotree",
    keys = { { "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "[U]ndo toggle", silent = true, noremap = true } },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    -- opts = { plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } } },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "[Z]en Mode", silent = true } },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    -- opts = function(_, opts)
    --   opts.mappings.add = "ys"
    --   opts.mappings.delete = "ds"
    --   opts.mappings.replace = "cs"
    -- end,
  },
  {
    "echasnovski/mini.ai",
    -- Disable to makesure that B and b works for {} and ()
    enabled = false,
  },
}
