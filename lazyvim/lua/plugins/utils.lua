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
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
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
}
