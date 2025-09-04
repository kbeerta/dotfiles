vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            workspace = {
                library = {
                    "${3rd}/luv/library",
                    vim.api.nvim_get_runtime_file("", true),
                },
                userThirdParty = { os.getenv("HOME") .. ".local/share/lua" },
                checkThirdParty = "Apply"
            }
        }
    }
})
