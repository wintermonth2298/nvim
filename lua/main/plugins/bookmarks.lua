return {
    'MattesGroeger/vim-bookmarks',
    config = function()
        vim.cmd [[let g:bookmark_save_per_working_dir = 1]]
    end
}
