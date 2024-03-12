return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-cmdline' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'onsails/lspkind-nvim' },
    },
    config = function()
        local lspkind = require('lspkind')
        local cmp = require 'cmp'
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-l>"] = cmp.mapping.confirm(),
                ['<C-h>'] = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources({
                { name = "path" },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
            }),
            formatting = {
                expandable_indicator = false,
                fields = { "abbr", "kind", "menu" },
                format = lspkind.cmp_format({
                    maxwidth = 50,
                })
            }
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_next_item(),
            }),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' }
            })
        })
    end
}
