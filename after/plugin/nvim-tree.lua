local function map(mod, lhs, rhs, opt)
    vim.api.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

require 'nvim-tree'.setup {
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
        mappings = {
            list = {
                { key = { "l", "<2-LeftMouse>" }, action = "edit" },
                { key = { "o", "<Tab>" },         action = "preview" },
            }
        }
    }
}

map('n', '<F1>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<F2>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })

local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end
    vim.cmd.enew()
    vim.cmd.bw(data.buf)
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
