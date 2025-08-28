require("mason").setup()
require("mason-lspconfig").setup()

require("plugins.config.lsp.lua_ls")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client == nil then
            return
        end

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ id = client.id, bufnr = args.buf, async = true, timeout_ms = 1000 })
                end
            })
        end

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            vim.api.nvim_create_autocmd("TextChangedI", { buffer = args.buf, callback = vim.lsp.completion.get })
        end
    end
})
