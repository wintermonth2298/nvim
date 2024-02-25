local M = {}

local function parse_args(args)
    local parsed = string.split_b(args, " ")
    return { tags = parsed[1], opts = parsed[2] }
end

vim.api.nvim_create_user_command('GoAddTags',
    function(opts)
        local parsed_args = parse_args(opts.args)

        if opts.line1 == 1 and opts.line2 == vim.api.nvim_buf_line_count(0) then
            local line = vim.api.nvim_win_get_cursor(0)[1]
            M:execute(line, line, parsed_args.tags, parsed_args.opts)
        else
            M:execute(opts.line1, opts.line2, parsed_args.tags, parsed_args.opts)
        end
    end,
    { nargs = "?", range = "%" }
)

function M:execute(line_start, line_end, tags, opts)
    vim.cmd("write")
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local selected_lines = self:get_lines(line_start, line_end)
    local command = self:create_command(filepath, selected_lines, tags, opts)
    vim.cmd(command)
    vim.cmd("edit")
    vim.cmd("write")
end

function M:create_command(filepath, lines, tags, opts)
    if tags == nil or tags == "" then
        tags = "json"
    end
    local command = string.format(":silent !gomodifytags -w -file %s -line %s -add-tags %s", filepath, lines, tags)
    if opts ~= nil and opts ~= "" then
        command = string.format("%s -add-options %s", command, opts)
    end
    return command
end

function M:get_lines(start, stop)
    local lines = ""
    for i = start, stop do
        lines = lines .. i .. ","
    end
    -- Удаляет последнюю запятую.
    return string.sub(lines, 1, -2)
end

return M
