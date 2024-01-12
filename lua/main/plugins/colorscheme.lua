return {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = {
        integrations = {
            aerial = true,
            alpha = true,
            cmp = true,
            dashboard = true,
            flash = true,
            gitsigns = true,
            headlines = true,
            illuminate = true,
            indent_blankline = { enabled = true },
            leap = true,
            lsp_trouble = true,
            mason = true,
            markdown = true,
            mini = true,
            which_key = true,
            harpoon = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
            navic = { enabled = true, custom_bg = "lualine" },
            neotest = true,
            nvimtree = true,
            semantic_tokens = true,
            telescope = {
                enabled = true,
                style = "nvchad"
            },
            treesitter = true,
            treesitter_context = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd [[colorscheme catppuccin]]
    end
}
