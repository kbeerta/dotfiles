vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true
})

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "BufHidden",
                "CursorMoved",
                "CursorMovedI",
                "InsertEnter",
                "InsertCharPre",
                "WinLeave"
            }
        })
    end
})

require("tokyonight").setup({
    style = "moon",
    transparent = true,
    plugins = {
        snacks = true,
        treesitter = true
    },
})

vim.cmd.colorscheme("tokyonight")

require("oil").setup({
    columns = {},
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
    lsp_file_methods = { enabled = true }
})

require("snacks").setup({
    indent = { enabled = true },
    picker = { enabled = true },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = vim.treesitter.start,
})

vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
