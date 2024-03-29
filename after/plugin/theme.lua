-- vim.cmd [[let g:gruvbox_material_foreground = "material"]]
-- vim.cmd [[let g:gruvbox_material_diagnostic_text_highlight = 1]]
-- vim.cmd [[let g:gruvbox_material_better_performance = 1]]
-- -- vim.cmd [[let g:gruvbox_material_diagnostic_virtual_text = 'colored']]
-- vim.cmd [[colorscheme gruvbox-material]]
--
-- -- for leap
-- vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#928374' })
--
-- vim.cmd [[hi HarpoonBorder guibg=background]]
-- vim.cmd [[hi HarpoonWindow guibg=background]]
--
require("catppuccin").setup({
    no_italic = true,
})

vim.cmd [[colorscheme catppuccin-macchiato]]
-- vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#928374' })
