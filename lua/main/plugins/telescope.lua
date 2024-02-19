return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
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
            { '<F1>',       "<cmd>Telescope file_browser<cr>" },
            { '<F2>',       "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>" },
            { '<leader>t:', "<cmd>Telescope commands<cr>" },
        }
    end,
    opts = function()
        local fb_actions = require("telescope._extensions.file_browser.actions")
        local actions = require("telescope.actions")
        local actions_set = require("telescope.actions.set")
        return {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes"),
                },
                ["file_browser"] = {
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            ["<A-y>"] = false,
                            ["<A-d>"] = false,
                            ["<C-e>"] = false,
                            ["<C-s>"] = false,
                            ["<C-a>"] = fb_actions.create,
                            ["<C-r>"] = fb_actions.rename,
                            ["<C-o>"] = fb_actions.open,
                            ["<C-g>"] = fb_actions.goto_parent_dir,
                            ["<C-w>"] = function() vim.cmd('normal vbd') end,
                            ["<C-t>"] = fb_actions.change_cwd,
                            ["<C-f>"] = fb_actions.toggle_browser,
                            ["<C-h>"] = fb_actions.toggle_hidden,
                            ["<bs>"] = fb_actions.backspace,
                        },
                    },
                },
            },
            defaults = {
                layout_strategy = "horizontal",
                sorting_strategy = "ascending",
                layout_config = {
                    height = 0.95,
                    width = 0.95,
                    horizontal = {
                        prompt_position = "top",
                    },
                },
                dynamic_preview_title = true,
                mappings = {
                    n = {
                        ["<C-d>"] = function(buf)
                            actions_set.shift_selection(buf, 10)
                        end,
                        ["<C-u>"] = function(buf)
                            actions_set.shift_selection(buf, -10)
                        end
                    },
                    i = {
                        ["<Down>"] = {
                            actions.cycle_history_next,
                            type = "action",
                            opts = { nowait = true, silent = true },
                        },
                        ["<Up>"] = {
                            actions.cycle_history_prev,
                            type = "action",
                            opts = { nowait = true, silent = true },
                        },
                        ["<C-j>"] = {
                            actions.move_selection_next,
                            type = "action",
                            opts = { nowait = true, silent = true },
                        },
                        ["<C-k>"] = {
                            actions.move_selection_previous,
                            type = "action",
                            opts = { nowait = true, silent = true },
                        },
                        ["<C-f>"] = {
                            actions.to_fuzzy_refine,
                            type = "action",
                            opts = { nowait = true, silent = true },
                        },
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("bookmarks")
        require("telescope").load_extension("file_browser")
    end
}
