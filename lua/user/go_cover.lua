local M = {}
local is_highlight_enabled = false

function M.open_go_cover_html()
end

function M.toggle_highlight()
    is_highlight_enabled = not is_highlight_enabled
    if is_highlight_enabled then
        -- Включить подсветку
        M.run_go_cover()
    else
        -- Отключить подсветку
        local bufnr = vim.api.nvim_get_current_buf()
        vim.fn.sign_unplace("GoCover", { buffer = bufnr })
        vim.fn.sign_unplace("GoNotCover", { buffer = bufnr })
    end
end

function M.open_coverage_html()
    is_highlight_enabled = true

    local nvim_api = vim.api
    local bufnr = nvim_api.nvim_get_current_buf()

    -- путь до каталога
    local filepath = nvim_api.nvim_buf_get_name(bufnr)
    local package_path = vim.fn.fnamemodify(filepath, ":h")

    local cover_filepath = "/tmp/cover.out"
    local command = string.format("go test -covermode=set -coverprofile %s %s", cover_filepath, package_path)

    -- Запуск команды в фоновом режиме
    local job_id = vim.fn.jobstart(command, {
        on_exit = M.get_open_coverage_html_func(cover_filepath)
    })

    -- Проверка на наличие ошибок при запуске команды
    if job_id <= 0 then
        print("Failed to start job for command:", command)
    end
end

function M.run_go_cover()
    is_highlight_enabled = true

    local nvim_api = vim.api
    local bufnr = nvim_api.nvim_get_current_buf()

    -- путь до каталога
    local filepath = nvim_api.nvim_buf_get_name(bufnr)
    local filename = string.match(filepath, "[^/]*$")
    local package_path = vim.fn.fnamemodify(filepath, ":h")

    local cover_filepath = "/tmp/cover.out"
    local command = string.format("go test --coverprofile %s %s", cover_filepath, package_path)

    -- Запуск команды в фоновом режиме
    local job_id = vim.fn.jobstart(command, {
        on_exit = M.get_highlight_func(bufnr, cover_filepath, filename)
    })

    -- Проверка на наличие ошибок при запуске команды
    if job_id <= 0 then
        print("Failed to start job for command:", command)
    end
end

function M.process_cover_file(cover_filepath, filename)
    local f = io.open(cover_filepath, "r")
    local covered_lines = {}
    local not_covered = {}

    if f == nil then
        print("/tmp/cover.out file does not exist")
        return {}, {}
    end

    for line in f:lines() do
        local filename_from_file, start_line, end_line, is_covered = line:match("(.*):(%d+).%d+,(%d+).%d+ %d+ (%d+)")

        if filename_from_file ~= nil and string.find(filename_from_file, filename) then
            if tonumber(is_covered) <= 0 then
                for i = start_line, end_line do
                    table.insert(not_covered, tonumber(i))
                end
            else
                for i = start_line, end_line do
                    table.insert(covered_lines, tonumber(i))
                end
            end
        end
    end
    f:close()
    return covered_lines, not_covered
end

function M.get_open_coverage_html_func(cover_filepath)
    return function()
        local command = string.format("go tool cover -html=%s", cover_filepath)
        vim.fn.system(command)
    end
end

function M.get_highlight_func(bufnr, cover_filepath, filename)
    return function()
        local covered_lines, not_covered = M.process_cover_file(cover_filepath, filename)

        -- Очистка выделения перед установкой нового
        vim.fn.sign_unplace("GoCover", { buffer = bufnr })
        vim.fn.sign_unplace("GoNotCover", { buffer = bufnr })

        -- Здесь мы устанавливаем выделение для покрытых строк
        vim.fn.sign_define("GoCover", { text = "▋", texthl = "SignColumn", numhl = "" })
        for _, lnum in ipairs(covered_lines) do
            vim.fn.sign_place(0, "GoCover", "GoCover", bufnr, { lnum = lnum, priority = 14 })
        end

        vim.fn.sign_define("GoNotCover", { text = "▋", texthl = "ErrorMsg", numhl = "" })
        for _, lnum in ipairs(not_covered) do
            vim.fn.sign_place(0, "GoNotCover", "GoNotCover", bufnr, { lnum = lnum, priority = 14 })
        end
    end
end

vim.api.nvim_command('command! GoCov lua require("user.go_cover").toggle_highlight()')
vim.api.nvim_command('command! GoCovHtml lua require("user.go_cover").open_coverage_html()')

return M
