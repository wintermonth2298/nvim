return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "go", "python", "lua", "markdown", "markdown_inline", "html", "json", "yaml" },
            auto_install = true,
            modules = {},
            sync_install = false,
            ignore_install = { "javascript" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
