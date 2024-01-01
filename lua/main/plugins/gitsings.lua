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
            end, "Goto next hunk")

            map('n', '<leader>sp', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, "Goto prev hunk")

            -- Actions
            map('n', '<leader>ss', gs.stage_hunk, "Stage hunk")
            map('n', '<leader>sr', gs.reset_hunk, "Reset hunk")
            map('v', '<leader>ss', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk")
            map('v', '<leader>sr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset hunk")
            map('n', '<leader>su', gs.undo_stage_hunk, "Undo stage hunk")
            map('n', '<leader>sS', gs.stage_buffer, "Stage buffer")
            map('n', '<leader>sR', gs.reset_buffer, "Reset buffer")
            map('n', '<leader>sh', gs.preview_hunk, "Preview hunk")
            map('n', '<leader>sb', function() gs.blame_line { full = true } end, "Blame line")
            map('n', '<leader>sd', gs.diffthis, "Diff this")
        end,
    },
}
