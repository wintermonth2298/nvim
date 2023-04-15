local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 80,
        })
    end,
})

local winte_group = augroup('Winte', {})
-- removes marks
-- autocmd({ "BufWritePre" }, {
--     group = winte_group,
--     pattern = "*",
--     command = [[%s/\s\+$//e]],
-- })
autocmd('Filetype', {
    group = winte_group,
    pattern = { 'go' },
    command = 'setlocal shiftwidth=8 tabstop=8 softtabstop=8'
})
autocmd({ "BufEnter" }, {
    group = winte_group,
    pattern = "*",
    command = [[set fo-=c fo-=r fo-=o]],
})
autocmd({ "InsertLeave" }, {
    group = winte_group,
    pattern = "*",
    command = "set nopaste",
})
autocmd({ "InsertEnter" }, {
    group = winte_group,
    pattern = "*",
    command = "set paste",
})

vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
