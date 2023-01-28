local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'dracula/vim', as = 'dracula'} -- Dracula theme
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- VScode like pictograms

  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'nvim-telescope/telescope.nvim' -- File Browser
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'windwp/nvim-autopairs' -- Automatic surrounding characters
  use 'windwp/nvim-ts-autotag' -- Automatic tag completion
  use { 'numToStr/Comment.nvim', -- Commenting
    requires = {
       'JoosepAlviste/nvim-ts-context-commentstring'
     }
  }

  use 'norcalli/nvim-colorizer.lua' -- Highlight color tags
  use 'folke/zen-mode.nvim' -- Zen Mode coding

  use({
      "iamcco/markdown-preview.nvim", -- Preview Markdown
      run = function() vim.fn["mkdp#util#install"]() end,
    })

  use 'akinsho/nvim-bufferline.lua' -- Top tab navigation

  use 'lewis6991/gitsigns.nvim' -- Git support for file
  use 'dinhhuy258/git.nvim' -- For git blame & browse

end)
