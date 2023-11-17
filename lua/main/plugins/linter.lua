return {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPost", "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.golangci_lint,
            },
        })
    end
}
