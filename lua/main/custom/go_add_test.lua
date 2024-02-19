local M = {}

vim.api.nvim_create_user_command('GoAddTest',
    function()
        M.add_func_test()
    end,
    { nargs = 0 }
)

local ts_utils = require('nvim-treesitter.ts_utils')

function M.add_func_test()
    local file_info = M.get_file_info()
    local function_name = M.get_current_function_name()

    local command = M.create_gotest_command(file_info.package_path, function_name)
    vim.cmd(command)
end

function M.create_gotest_command(package_path, function_name)
    local command = string.format("!gotests -w -only %s %s", function_name, package_path)
    return command
end

function M.get_current_function_name()
    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then return "" end
    local expr = current_node

    local function_expr = {}
    while expr do
        if expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
            function_expr = expr
        end
        expr = expr:parent()
    end

    if not function_expr then return "" end

    if function_expr:type() == 'function_declaration' then
        return ts_utils.get_node_text(function_expr:child(1))[1]
    end

    if function_expr:type() == "method_declaration" then
        return ts_utils.get_node_text(function_expr:child(2))[1]
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
