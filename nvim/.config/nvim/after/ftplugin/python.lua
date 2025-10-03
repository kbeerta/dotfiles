local util = require("util")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = '*.py',
    callback = function()
        util.add_new_line_to_eof()
    end
})
