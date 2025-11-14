local M = {}

M.setup = function()

    if vim.g.editorconfig_enable == false or vim.g.editorconfig_enable == 0 then
        return
    end

    local editorconfig = require("editorconfig")
    local group = vim.api.nvim_create_augroup("custom-editorconfig", {})

    -- improved version of the code below which includes removing trailing blanklines
    -- https://github.com/neovim/neovim/blob/d017f3c9a0b745e0c57feb8c92dcc852948f7301/runtime/lua/editorconfig.lua#L145
    editorconfig.properties.trim_trailing_whitespace = function(bufnr, val)
        assert(val == "true" or val == "false", "trim_trailing_whitespace must be either \"true\" or \"false\"")
        if val == "true" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = bufnr,
                callback = function()
                    local view = vim.fn.winsaveview()
                    vim.api.nvim_command('silent! undojoin')
                    vim.api.nvim_command('silent keepjumps keeppatterns %s/\\s\\+$//e')
                    vim.fn.winrestview(view)

                    local n_lines = vim.api.nvim_buf_line_count(0)
                    local last_nonblank = vim.fn.prevnonblank(n_lines)
                    if last_nonblank < n_lines then vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {}) end
                end,
            })
        else
            vim.api.nvim_clear_autocmds({
                group = group,
                event = "BufWritePre",
                buffer = bufnr,
            })
        end
    end
end

return M
