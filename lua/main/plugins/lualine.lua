return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
        options = {
            disabled_filetypes = { 'packer', 'NvimTree' }
        }
    }
}
