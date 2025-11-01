local M = {}

M.setup = function()

    if vim.g.editorconfig_enable == false or vim.g.editorconfig_enable == 0 then
        return
    end

    local editorconfig = require("editorconfig")
    local group = vim.api.nvim_create_augroup("custom-editorconfig", {})

    editorconfig.properties.vim_insert_final_blankline = function(bufnr, val)
        assert(val == "true" or val == "false", "insert_final_blankline must be either \"true\" or \"false\"")

        if val == "true" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = bufnr,
                callback = function()
                    local view = vim.fn.winsaveview()
                    vim.api.nvim_command("silent! undojoin")
                    vim.api.nvim_command("silent keepjumps keeppatterns $s/^.\\+$/&\\r/e")
                    vim.fn.winrestview(view)
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
