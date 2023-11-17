return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "go", "python", "lua", "markdown", "markdown_inline", "html", "json" },
            auto_install = true,
            modules = {},
            sync_install = false,
            ignore_install = { "javascript" },
            textobjects = {
                select = {
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                    },
                },
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}