require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require "luasnip"

luasnip.config.set_config {
    history = true,
    region_check_events = "CursorMoved"
}

vim.cmd [[imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '']]
vim.cmd [[imap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>]]
vim.cmd [[smap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '']]
vim.cmd [[smap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>]]
