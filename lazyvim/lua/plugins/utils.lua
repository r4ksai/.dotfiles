return {
  {
    "mbbill/undotree",
    keys = { { "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "[U]ndo toggle", silent = true, noremap = true } },
  },
  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "[Z]en Mode", silent = true } },
  },
  {
    "echasnovski/mini.surround",
    opts = function(_, opts)
      opts.mappings.add = "ys"
      opts.mappings.delete = "ds"
      opts.mappings.replace = "cs"
    end,
  },
}
