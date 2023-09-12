local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'o', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
end

require 'nvim-tree'.setup {
    on_attach = on_attach,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    disable_netrw = true,
    view = {
        adaptive_size = true,
    }
}

vim.api.nvim_set_keymap('n', '<F1>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
