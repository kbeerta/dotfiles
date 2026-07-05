vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "None" })

-- :keymaps

vim.keymap.set({ "n" }, "-", "<CMD>Ex<CR>", { desc = "Open netrw" })
vim.keymap.set({ "n" }, "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })

-- :options

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = ".", nbsp = "_" }

vim.o.autocomplete = true
vim.opt.completeopt = "menu,menuone,noselect,popup"

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"

vim.opt.hlsearch = true
-- vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.undofile = true

-- :lsp

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

for _, config in ipairs(vim.lsp.get_configs()) do
    local cmd = config.cmd
    local name = config.name
    if cmd and type(cmd) == "table" and type(cmd[1]) == "string" and vim.fn.exepath(cmd[1]) ~= "" then
        vim.lsp.enable(name)
    end
end
