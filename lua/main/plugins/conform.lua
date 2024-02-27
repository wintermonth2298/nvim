return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {

        -- Define your formatters
        formatters_by_ft = {
            go = { "goimports", "gofmt", "golines" },
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { { "prettierd", "prettier" } },
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        -- Customize formatters
        formatters = {
            golines = {
                prepend_args = { "-m", "130" },
            },
            goimports = {
                prepend_args = function(self, _)
                    if vim.fn.executable("go") ~= 1 then
                        return
                    end

                    local module = vim.fn.trim(vim.fn.system("go list -m"))
                    if vim.v.shell_error ~= 0 then
                        return
                    end
                    module = module:gsub("\n", ",")

                    return { "-local", module }
                end
            }
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
