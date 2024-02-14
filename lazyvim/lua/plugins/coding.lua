return {
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<C-n>"] = function(_)
  --         if cmp.visible() then
  --           cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         else
  --           cmp.complete()
  --         end
  --       end,
  --       ["<C-p>"] = function(_)
  --         if cmp.visible() then
  --           cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           cmp.complete()
  --         end
  --       end,
  --     })
  --   end,
  -- },
  --
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./custom-snippets" } })
    end,
  },
  { "smjonas/inc-rename.nvim", cmd = "IncRename", config = true },
}
