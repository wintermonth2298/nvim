return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim"
    },
    keys = function()
        return {
            { "<leader>tF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>" },
            { "<leader>tf", "<cmd>Telescope git_files hidden=true no_ignore=true<cr>" },
            { "<leader>tb", "<cmd>Telescope buffers<cr>" },
            { "<leader>tg", "<cmd>Telescope live_grep use_less=true<cr>" },
            { "<leader>tl", "<cmd>Telescope resume<cr>" },
            { "<leader>t'", "<cmd>Telescope registers<cr>" },
            { '<leader>tm', "<cmd>Telescope bookmarks<cr>" },
            { '<leader>t:', "<cmd>Telescope commands<cr>" },
        }
    end,
    opts = {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes"),
            },
        },
        defaults = {
            layout_config = { height = 0.95, width = 0.95 },
            dynamic_preview_title = true,
            mappings = {
                i = {
                    ["<Down>"] = {
                        require("telescope.actions").cycle_history_next,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ["<Up>"] = {
                        require("telescope.actions").cycle_history_prev,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ["<C-j>"] = {
                        require("telescope.actions").move_selection_next,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ["<C-k>"] = {
                        require("telescope.actions").move_selection_previous,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ["<C-f>"] = {
                        require("telescope.actions").to_fuzzy_refine,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                },
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("bookmarks")
    end
}
