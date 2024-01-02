local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'o', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
end


return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<F1>", ":NvimTreeToggle<CR>",         silent = true },
        { "<F2>", ":NvimTreeFindFileToggle<CR>", silent = true },
    },
    opts = {
        on_attach = on_attach,
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        disable_netrw = true,
        view = {
            adaptive_size = true,
        }
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
}
