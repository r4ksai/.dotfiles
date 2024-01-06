return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.theme = "dracula"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.mode = "tabs"
      -- opts.options.separator_style = "slant"
      opts.options.always_show_bufferline = false
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icons = false
      opts.options.color_icons = false
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.open = {
        enable = false,
      }
      opts.close = {
        enable = false,
      }
      opts.scroll = {
        enable = false,
      }
    end,
  },
}
