local M = {
    is_highlight_enabled = false,
    coverage_filename = "/tmp/cover.out",
    group_covered = "GoCovered",
    group_not_covered = "GoNotCovered",
}

vim.api.nvim_command('command! GoCov lua require("user.go_cover").toggle_coverage()')
vim.api.nvim_command('command! GoCovHtml lua require("user.go_cover").open_coverage_in_browser()')

function M.open_coverage_in_browser()
    local file_info = M.get_file_info()
    local create_coverage_file_command = string.format(
        "go test -covermode=set -coverprofile %s %s",
        M.coverage_filename,
        file_info.package_path
    )
    local open_html_command = string.format(
        "go tool cover -html=%s",
        M.coverage_filename
    )

    vim.fn.jobstart(create_coverage_file_command, {
        on_exit = function()
            vim.fn.system(open_html_command)
        end
    })
end

function M.toggle_coverage()
    local file_info = M.get_file_info()
    if not M.is_highlight_enabled then
        M.enable_highlighting(file_info)
    else
        M.disable_highlighting(file_info.bufnr)
    end

    M.is_highlight_enabled = not M.is_highlight_enabled
end

function M.enable_highlighting(file_info)
    local create_coverage_file_command = string.format(
        "go test -covermode=set -coverprofile %s %s",
        M.coverage_filename,
        file_info.package_path
    )

    vim.fn.jobstart(create_coverage_file_command, {
        on_exit = function()
            local lines_covered, lines_not_covered = M.get_covered_and_not_coverd_lines_for_file(file_info.name)
            M.highlight_lines_green(file_info.bufnr, lines_covered, M.group_covered)
            M.highlight_lines_red(file_info.bufnr, lines_not_covered, M.group_not_covered)
        end
    })
end

function M.get_file_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local filename = string.match(filepath, "[^/]*$")
    local package_path = vim.fn.fnamemodify(filepath, ":h")
    return {
        bufnr = bufnr,
        name = filename,
        package_path = package_path,
    }
end

function M.get_covered_and_not_coverd_lines_for_file(filename)
    local lines_covered = {}
    local lines_not_covered = {}

    for line in io.lines(M.coverage_filename) do
        local filename_from_file, start_idx, end_idx, num_covered = line:match("(.*):(%d+).%d+,(%d+).%d+ %d+ (%d+)")

        if filename_from_file == nil then
            goto continue
        end

        if not string.find(filename_from_file, filename) then
            goto continue
        end

        if tonumber(num_covered) > 0 then
            for i = start_idx, end_idx do
                table.insert(lines_covered, tonumber(i))
            end
        else
            for i = start_idx, end_idx do
                table.insert(lines_not_covered, tonumber(i))
            end
        end

        ::continue::
    end
    return lines_covered, lines_not_covered
end

function M.disable_highlighting(bufnr)
    for _, group in ipairs({ M.group_covered, M.group_not_covered }) do
        vim.fn.sign_unplace(group, { buffer = bufnr })
    end
end

function M.highlight_lines_red(bufnr, lines, group)
    vim.fn.sign_define(group, { text = "▋", texthl = "ErrorMsg", numhl = "" })
    M.highlight_lines(bufnr, lines, group)
end

function M.highlight_lines_green(bufnr, lines, group)
    vim.fn.sign_define(group, { text = "▋", texthl = "RainbowDelimiterGreen", numhl = "" })
    M.highlight_lines(bufnr, lines, group)
end

function M.highlight_lines(bufnr, lines, group)
    for _, line in ipairs(lines) do
        vim.fn.sign_place(0, group, group, bufnr, { lnum = line, priority = 14 })
    end
end

return M
