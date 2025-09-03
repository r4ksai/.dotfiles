return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()

      local Terminal = require("toggleterm.terminal").Terminal
      local cz_term = Terminal:new({
        cmd = "cz c",
        hidden = true,
        direction = "float",
      })

      vim.keymap.set("n", "<leader>cz", function()
        cz_term:toggle()
      end, { desc = "Commit with Commitizen" })
    end,
  },
}
