-- return {
--   "Mofiqul/dracula.nvim",
--   lazy = true,
--   priority = 1000,
--   opts = function()
--     return {
--       transparent_bg = true,
--     }
--   end,
-- }

return {
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      style = "moon",
    }
  end,
}
