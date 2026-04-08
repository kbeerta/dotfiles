vim.g.mapleader = " "
vim.g.localmapleader = " "

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

vim.opt.undofile = true

vim.keymap.set({ "n" }, "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.cmd.colorscheme("catppuccin")
