return {
    'crusj/bookmarks.nvim',
    lazy = false,
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    opts = {
        keymap = {
            add = "mm",
            delete_on_virt = "md",
            show_desc = "mk",
        },
    },
    config = function(_, opts)
        require("bookmarks").setup(opts)
    end
}
