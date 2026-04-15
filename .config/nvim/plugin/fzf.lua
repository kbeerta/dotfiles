vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup({"ivy"})

vim.keymap.set({ "n" }, "<leader>fp", "<CMD>FzfLua global<CR>", { desc = "Global fuzzy picker" })
