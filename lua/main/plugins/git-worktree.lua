return {
    "ThePrimeagen/git-worktree.nvim",
    opts = {
        change_directory_command = "lcd",
        update_on_change = false,
    },
    keys = function()
        return {
            { "<leader>tw", require('telescope').extensions.git_worktree.git_worktrees,       silent = true, desc = "Worktrees show" },
            { "<leader>tW", require('telescope').extensions.git_worktree.create_git_worktree, silent = true, desc = "Worktrees create" },
        }
    end,
    config = function(_, opts)
        require("telescope").load_extension("git_worktree")
        require("git-worktree").setup(opts)
    end
}
