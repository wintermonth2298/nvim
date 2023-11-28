return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
    keys = function()
        return {
            { "<C-f>",     "<cmd>Telescope find_files hidden=true no_ignore=true<cr>" },
            { "<C-p>",     "<cmd>Telescope git_files hidden=true no_ignore=true<cr>" },
            { "<leader>b", "<cmd>Telescope buffers<cr>" },
            { "<leader>g", "<cmd>Telescope live_grep<cr>" },
            { "<leader>l", "<cmd>Telescope resume<cr>" },
            { "<leader>'", "<cmd>Telescope registers<cr>" },
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
}
