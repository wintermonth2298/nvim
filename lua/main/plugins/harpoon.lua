return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {
        menu = {
            width = 90,
            height = 15,
        },
    },
    lazy = false,
    keys = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        return {
            { "<leader>a", function() mark.add_file() end },
            { "<leader>h", function() ui.toggle_quick_menu() end },
            { "<leader>1", function() ui.nav_file(1) end },
            { "<leader>2", function() ui.nav_file(2) end },
            { "<leader>3", function() ui.nav_file(3) end },
            { "<leader>4", function() ui.nav_file(4) end },
        }
    end
}
