
local M = {}

M.add_new_line_to_eof = function ()
    local line_count = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(line_count)
    if last_nonblank <= line_count then
        vim.api.nvim_buf_set_lines(0, last_nonblank, line_count, true, { '' })
    end
end

return M
