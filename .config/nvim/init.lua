vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "None" })

-- :keymaps

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

vim.opt.foldlevel = 99

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"

vim.opt.hlsearch = true
vim.opt.termguicolors = true

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

local servers = {}
for _, file in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local server_name = vim.fn.fnamemodify(file, ":t:r")
    table.insert(servers, server_name)
end

vim.lsp.enable(servers)

-- :treesitter

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*', -- Matches every filetype
  callback = function()
    local lang = vim.bo.filetype
    if vim.treesitter.query.get(lang, "highlights") then
      vim.treesitter.start()
    end
  end,
})

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- :explorer
vim.pack.add({ "https://github.com/echasnovski/mini.icons" })
vim.pack.add({ "https://github.com/echasnovski/mini.files" })

require("mini.icons").setup({})
require("mini.files").setup({})

vim.keymap.set({ "n" }, "-", MiniFiles.open, { desc = "Open netrw" })

-- :picker

vim.pack.add({ "https://github.com/echasnovski/mini.pick" })

require("mini.pick").setup({
    source = {
        show = function(buf_id, items, query)
            require("mini.pick").default_show(buf_id, items, query, { show_icons = false })
        end
    }
})

vim.keymap.set("n", "<leader>ff", "<CMD>Pick files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", "<CMD>Pick buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fg", "<CMD>Pick grep_live<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fr", "<CMD>Pick resume<CR>", { desc = "Resume latest picker" })
