local function find_buffer_with_regex(regex)
    local buffers = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match(regex) then
            return bufnr
        end
    end
    return nil
end


local function toggle()
    local fugitive_buf_no = find_buffer_with_regex('^fugitive:')
    if fugitive_buf_no == nil then
        vim.cmd(":G")
        return
    end

    local buf_win_id = vim.fn.bufwinid(fugitive_buf_no)
    if fugitive_buf_no >= 0 and buf_win_id >= 0 then
        vim.api.nvim_win_close(buf_win_id, false)
    else
        vim.cmd(":G")
    end
end

return {
    "tpope/vim-fugitive",
    keys = function()
        return {
            { "<leader>gg", toggle, silent = true, desc = "Toggle Git" },
        }
    end
}
