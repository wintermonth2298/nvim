return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
        window = {
            mappings = {
                ["l"] = "open",
            },
        },
    },
    keys = {
        { "<F1>", ":Neotree toggle<cr>" },
        { "<F2>", ":Neotree toggle reveal_force_cwd<cr>" },
        { "<F3>", ":Neotree toggle git_status<cr>" },
    },
}
