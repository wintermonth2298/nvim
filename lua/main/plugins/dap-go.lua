return {
    lazy = false,
    'leoluz/nvim-dap-go',
    dependencies = {
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
        require("dapui").setup()
        require("dap-go").setup()
        require("nvim-dap-virtual-text").setup({
            commented = false,
        })

        vim.fn.sign_define(
            "DapBreakpoint",
            { text = "⚫", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
        )

        local function opts(desc)
            return { silent = true, desc = desc }
        end
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>uc", function() dap.continue() end, opts("Continue"))
        vim.keymap.set("n", "<leader>us", function() dap.disconnect() end, opts("Stop"))
        vim.keymap.set("n", "<leader>ur", function() dap.restart() end, opts("Restart"))
        vim.keymap.set("n", "<leader>ub", function() dap.toggle_breakpoint() end, opts("Toggle breakpoint"))
        vim.keymap.set("n", "<leader>uB", function() dap.clear_breakpoints() end, opts("Clear breakpoints"))
        vim.keymap.set("n", "<leader>uj", function() dap.step_over() end, opts("Step over"))
        vim.keymap.set("n", "<leader>un", function() dap.step_into() end, opts("Step into"))
        vim.keymap.set("n", "<leader>up", function() dap.step_out() end, opts("Step out"))
        vim.keymap.set("n", "<leader>uo", function() dapui.open({ reset = true }) end, opts("Open DapUI"))
        vim.keymap.set("n", "<leader>ut", function() dapui.toggle() end, opts("Toggle DapUI"))
    end
}
