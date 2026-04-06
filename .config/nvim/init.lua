vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = ".", nbsp = "_" }

vim.opt.hlsearch = true

vim.keymap.set({ "n" }, "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.cmd.colorscheme("catppuccin")
