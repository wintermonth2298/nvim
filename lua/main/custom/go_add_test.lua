local M = {}

vim.api.nvim_create_user_command('GoAddTest',
    function()
        M.add_func_test()
    end,
    { nargs = 0 }
)

function M.add_func_test()
    local file_info = M.get_file_info()
    local function_name = M.get_current_function_name()

    local command = M.create_gotest_command(file_info.package_path, function_name)
    vim.cmd(command)

    local current_dir = vim.fn.expand('%:p:h')
    local new_file = current_dir .. '/' .. file_info.name:gsub(".go", "") .. "_test.go"
    vim.cmd(":silent edit " .. new_file)
    vim.cmd(":silent norm G{j")
end

function M.create_gotest_command(package_path, function_name)
    local command = string.format(":silent !gotests -parallel -w -only ^%s$ %s", function_name, package_path)
    return command
end

function M.get_current_function_name()
    local current_node = vim.treesitter.get_node()
    if not current_node then return "" end
    local expr = current_node

    while expr do
        if expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
            break
        end
        expr = expr:parent()
    end

    if not expr then return "" end

    local bufnr = vim.api.nvim_get_current_buf()
    if expr:type() == 'function_declaration' then
        return vim.treesitter.get_node_text(expr:child(1), bufnr)
    end

    if expr:type() == "method_declaration" then
        return vim.treesitter.get_node_text(expr:child(2), bufnr)
    end
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

return M
