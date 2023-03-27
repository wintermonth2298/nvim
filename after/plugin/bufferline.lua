local function map(mod, lhs, rhs, opt)
    vim.api.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        separator_style = { '', '' },
        show_buffer_close_icons = false,
        indicator = {
            style = "none"
        },
        diagnostics_indicator = function() return '*' end,
        offsets = {
            { filetype = "NvimTree", text = "File Explorer" },
        },
    }
}

map('n', '<A-C-l>', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
map('n', '<A-C-h>', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
map('n', '<S-l>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
map('n', '<S-h>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
