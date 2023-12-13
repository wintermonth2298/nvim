local M = {}

vim.api.nvim_create_user_command('GoTestF',
    function(args)
        M.test_func(args)
    end,
    { nargs = "*" }
)

local toggleterm = require("toggleterm")
local ts_utils = require('nvim-treesitter.ts_utils')

function M.test_func(args)
    local file_info = M.get_file_info()
    local command_args = M.parse_args(args)
    local function_name = M.get_current_function_name()

    local command = M.create_command(command_args, file_info.package_path, function_name)

    toggleterm.exec_command(string.format("cmd=%s", command), 0)
end

function M.create_command(command_args, package_path, function_name)
    local command = ""
    if command_args == "" then
        command = string.format("'go test %s -run %s'", package_path, function_name)
    else
        command = string.format("'go test %s %s -run %s'", command_args, package_path, function_name)
    end

    return command
end

function M.parse_args(args)
    local command_args = ""
    for num, arg in pairs(args.fargs) do
        if num ~= 1 then
            command_args = command_args .. " "
        end
        command_args = command_args .. arg
    end
    return command_args
end

function M.get_current_function_name()
    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then return "" end
    local expr = current_node

    while expr do
        if expr:type() == 'function_declaration' then
            break
        end
        expr = expr:parent()
    end

    if not expr then return "" end

    return (ts_utils.get_node_text(expr:child(1)))[1]
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
