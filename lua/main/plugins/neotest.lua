return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    config = true,
    keys = {
        { "<leader>To", function() require("neotest").summary.toggle() end, silent = true },
        { "<leader>Tr", function() require("neotest").run.run() end,        silent = true },
    },
    opts = function()
        return {
            adapters = {
                require("neotest-go")({
                    recursive_run = true,
                    experimental = {
                        test_table = true,
                    },
                })
            }
        }
    end
}
