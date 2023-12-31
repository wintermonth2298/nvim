return {
    "ThePrimeagen/git-worktree.nvim",
    keys = function()
        return {
            { "<leader>w", require('telescope').extensions.git_worktree.git_worktrees,       silent = true },
            { "<leader>W", require('telescope').extensions.git_worktree.create_git_worktree, silent = true },
        }
    end,
    config = function(_, opts)
        require("telescope").load_extension("git_worktree")
        require("git-worktree").setup(opts)
    end
}
