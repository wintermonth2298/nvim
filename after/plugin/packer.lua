vim.cmd [[packadd packer.nvim]]

-- Add packages
return require('packer').startup(function()
    use('wbthomason/packer.nvim')
    use('echasnovski/mini.comment')
    use('echasnovski/mini.cursorword')
    use('sainnhe/gruvbox-material')
    use("theprimeagen/harpoon")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        }
    }

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use("nvim-treesitter/nvim-treesitter-context");
    use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

    use('lewis6991/gitsigns.nvim')

    use('neovim/nvim-lspconfig')
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            -- Autocompletion
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-cmdline' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    }
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
        'ray-x/go.nvim',
        requires = { "ray-x/guihua.lua" },
    }
    use('ray-x/lsp_signature.nvim')
    use('onsails/lspkind-nvim')
    use({ 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons' })
    use({ "akinsho/toggleterm.nvim", tag = '*' })

    use('ggandor/leap.nvim')
    use("tpope/vim-fugitive")
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use { "bluz71/vim-nightfly-colors", as = "nightfly" }
    use { "folke/neodev.nvim" }
    use { "catppuccin/nvim", as = "catppuccin" }
end)
