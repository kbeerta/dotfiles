local keymaps = {
    {
        mode = "n",
        keys = "<esc>",
        callback = function()
            vim.cmd("noh")
        end
    },
    {
        mode = "n",
        keys = "<S-l>",
        callback = function()
            vim.cmd("bnext")
        end
    },
    {
        mode = "n",
        keys = "-",
        callback = function()
            require("oil").open()
        end
    },
    {
        mode = "n",
        keys = "<S-h>",
        callback = function()
            vim.cmd("bprev")
        end
    },
    {
        mode = "n",
        keys = "<leader>ff",
        callback = Snacks.picker.files
    },
    {
        mode = "n",
        keys = "<leader>fr",
        callback = function()
            Snacks.picker.recent({ filter = { paths = { [vim.fn.getcwd()] = true } } })
        end
    },
    {
        mode = "n",
        keys = "<leader>fb",
        callback = Snacks.picker.buffers
    },
    {
        mode = "n",
        keys = "<leader>ww",
        callback = function()
            local bufnr = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_open_win(bufnr, true, {
                split = "below",
                win = 0
            })
        end
    },
}

for _, keymap in ipairs(keymaps) do
    local opts = vim.tbl_extend("force", keymap.opts or {}, { noremap = true, silent = true })
    vim.keymap.set(keymap.mode, keymap.keys, keymap.callback, opts);
end
