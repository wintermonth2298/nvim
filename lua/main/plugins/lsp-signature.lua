return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        handler_opts = { border = "rounded" },
        hint_prefix = "",
        hint_enable = false,
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
}
