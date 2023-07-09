local actions = require('telescope.actions')

require('telescope').setup({
    pickers = {
        live_grep = {
            mappings = {
                i = { ["<c-f>"] = actions.to_fuzzy_refine },
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes")
        }
    },
    defaults = {
        mappings = {
            i = {
                ["<Down>"] = { require('telescope.actions').cycle_history_next, type = "action",
                    opts = { nowait = true, silent = true },
                },
                ["<Up>"] = { require('telescope.actions').cycle_history_prev, type = "action",
                    opts = { nowait = true, silent = true },
                },
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

require("telescope").load_extension("ui-select")

vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', {})
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files hidden=true no_ignore=true<cr>', {})
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<cr>', {})
