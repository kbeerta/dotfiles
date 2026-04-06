vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.bo.indentexpr = "v:lua.require(\"nvim-treesitter\").indentexpr()"

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = function() vim.treesitter.start() end
})
