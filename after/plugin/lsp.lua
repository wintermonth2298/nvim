-- Setup language servers.
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
    vim.keymap.set('n', '<F3>', builtin.lsp_document_symbols, opts)
    vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
    -- vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
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

require('go').setup({
    lsp_cfg = {
        capabilities = capabilities,
        on_attach = on_attach
    },
    dap_debug = false,
    lsp_inlay_hints = {
        enable = false,
    },
    luasnip = true,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})

require 'lsp_signature'.setup({
    handler_opts = { border = "rounded" },
    hint_prefix = "",
    doc_lines = 0,
    hint_enable = false,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = true,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
    }
)
