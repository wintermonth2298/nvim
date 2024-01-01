return {
    "ThePrimeagen/git-worktree.nvim",
    keys = function()
        return {
            { "<leader>w", require('telescope').extensions.git_worktree.git_worktrees,       silent = true, desc = "Worktrees show" },
            { "<leader>W", require('telescope').extensions.git_worktree.create_git_worktree, silent = true, desc = "Worktrees create" },
        }
    end,
    config = function(_, opts)
        require("telescope").load_extension("git_worktree")
        require("git-worktree").setup(opts)
    end
}
