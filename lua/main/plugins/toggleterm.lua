return {
    "akinsho/toggleterm.nvim",
    opts = {
        open_mapping = [[<F4>]],
        shade_terminals = false,
        terminal_mappings = true,
        direction = 'float',
        on_close = function()
            require("neo-tree.events").fire_event("git_event")
        end
    }
}
