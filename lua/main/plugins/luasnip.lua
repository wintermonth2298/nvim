return {
    "L3MON4D3/LuaSnip",
    version = "v2.1",
    build = "make install_jsregexp",
    dependencies = {
        { "rafamadriz/friendly-snippets" },
    },
    opts = {
        config = {
            history = true,
            region_check_events = "CursorMoved"
        }
    },
    config = function(_, opts)
        require("luasnip.loaders.from_vscode").lazy_load()

        require("luasnip").setup(opts)

        vim.cmd [[imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '']]
        vim.cmd [[imap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>]]
        vim.cmd [[smap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '']]
        vim.cmd [[smap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>]]
    end
}
