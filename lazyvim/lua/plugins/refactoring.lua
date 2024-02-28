return {
  { "smjonas/inc-rename.nvim", cmd = "IncRename", config = true },
  {
    "ThePrimeagen/refactoring.nvim",
    depends = { "nvim-treesitter", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>cc",
        function()
          require("refactoring").select_refactor({ show_success_message = true })
        end,
        desc = "Refactoring",
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor({ show_success_message = true })
        end,
        desc = "Refactoring",
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    config = function()
      require("refactoring").setup()
    end,
  },
}
