return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
        { "hrsh7th/cmp-nvim-lsp" },
        { "folke/neodev.nvim" },
    },
    event = { "BufReadPost", "BufReadPre", "BufNewFile" },
    config = function(_, _)
        local lspconfig = require('lspconfig')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev)
        vim.keymap.set('n', '<leader>q', builtin.diagnostics)

        local on_attach = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
            vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
            vim.keymap.set('n', '<leader>i', builtin.lsp_implementations, opts)
            vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, opts)
            vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, opts)
            -- vim.keymap.set('n', '<F3>', builtin.lsp_document_symbols, opts)
            vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig['bashls'].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }

        lspconfig['pyright'].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }

        require("neodev").setup({})
        lspconfig['lua_ls'].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'use' },
                    },
                }
            }
        }

        lspconfig["gopls"].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            }
        }

        local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            }
        )
    end
}
