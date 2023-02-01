-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

local status, packer = pcall(require, 'packer')
if (not status) then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager

    use { 'dracula/vim', as = 'dracula' } -- Dracula theme
    use 'nvim-lualine/lualine.nvim' -- Statusline

    use 'kyazdani42/nvim-web-devicons' -- File icons
    use 'onsails/lspkind-nvim' -- VScode like pictograms

    use { 'hrsh7th/nvim-cmp', -- Autocompletion
        requires = {
            'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
            'hrsh7th/cmp-path', -- nvim-cmp source for file paths
            'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in LSP

            'L3MON4D3/LuaSnip', -- Snippet engine
            'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for luasnip
            'rafamadriz/friendly-snippets', -- Snippets for different programming langauges
        }
    }

    use { 'neovim/nvim-lspconfig', -- LSP Configs
        requires = {
            'williamboman/mason.nvim', -- Langauge server manager
            'williamboman/mason-lspconfig.nvim',

            'jose-elias-alvarez/null-ls.nvim', -- Linting, Formating and Actions
            'glepnir/lspsaga.nvim', -- LSP UIs

            'j-hui/fidget.nvim', -- Useful status updates for LSP
            'folke/neodev.nvim', -- Lua support for neovim config
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        requires = {
            'nvim-lua/plenary.nvim', -- Common utilities for treesitter
            'p00f/nvim-ts-rainbow', -- Colored brackers and tags
            'windwp/nvim-ts-autotag' -- Automatic tag completion and rename
        }
    }

    use 'norcalli/nvim-colorizer.lua' -- Highlight color tags

    use 'nvim-telescope/telescope.nvim' -- Fuzzy Finder
    use 'nvim-telescope/telescope-file-browser.nvim' -- File Browser

    use 'windwp/nvim-autopairs' -- Automatic surrounding characters
    use 'kylechui/nvim-surround' -- Shortcuts to for automatic surrounds

    use {
        'folke/todo-comments.nvim', -- TODO comments
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use { 'numToStr/Comment.nvim', -- Commenting
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring'
        }
    }
    use 'mbbill/undotree' -- Interactive undo tree

    use 'folke/zen-mode.nvim' -- Zen Mode coding

    use({
        'iamcco/markdown-preview.nvim', -- Preview Markdown
        run = function() vim.fn['mkdp#util#install']() end,
    })

    use 'akinsho/nvim-bufferline.lua' -- Top tab navigation

    use 'lewis6991/gitsigns.nvim' -- Git support for file
    use 'dinhhuy258/git.nvim' -- For git blame & browse
    use 'tpope/vim-fugitive'


    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})
