return {
    "akinsho/bufferline.nvim",
    keys = function()
        return {
            { "<S-l>", ":BufferLineCycleNext<CR>", silent = true },
            { "<S-h>", ":BufferLineCyclePrev<CR>", silent = true },
        }
    end,
    opts = {
        options = {
            mode = "tabs",
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            separator_style = { "", "" },
            show_buffer_close_icons = false,
            indicator = {
                style = "none",
            },
            diagnostics_indicator = function()
                return "*"
            end,
            offsets = {
                { filetype = "NvimTree", text = "File Explorer" },
            },
        },
    },
}
