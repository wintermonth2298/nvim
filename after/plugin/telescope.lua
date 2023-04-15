require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = {
                    require('telescope.actions').move_selection_next, type = "action",
                    opts = { nowait = true, silent = true }
                },
                ["<C-k>"] = {
                    require('telescope.actions').move_selection_previous, type = "action",
                    opts = { nowait = true, silent = true }
                },
            },
        },
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', {})
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files hidden=true no_ignore=true<cr>', {})
vim.keymap.set('n', '<C-g>', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<cr>', {})
