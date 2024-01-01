return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "▎" },
            topdelete = { text = "▎" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            map('n', '<leader>sn', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '<leader>sp', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map('n', '<leader>ss', gs.stage_hunk)
            map('n', '<leader>sr', gs.reset_hunk)
            map('v', '<leader>ss', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('v', '<leader>sr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('n', '<leader>su', gs.undo_stage_hunk)
            map('n', '<leader>sS', gs.stage_buffer)
            map('n', '<leader>sR', gs.reset_buffer)
            map('n', '<leader>sp', gs.preview_hunk)
            map('n', '<leader>sb', function() gs.blame_line { full = true } end)
            map('n', '<leader>sd', gs.diffthis)
        end,
    },
}
