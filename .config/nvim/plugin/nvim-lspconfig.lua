vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then 
            return 
        end

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
                autotrigger = true,
            })
        end
    end
})
