-- :options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.eol = true
vim.o.fixeol = true

vim.o.breakindent = true

vim.o.undofile = true
vim.o.swapfile = false

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Hide search highlight" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus top window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus bottom window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- :plugins

require("plugins")

-- :file

require("oil").setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil file explorer" })

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        rust = { "rustfmt", lsp_format = "fallback" },
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)

-- :picker

require("snacks").setup({
    picker = {
        enabled = true,
        auto_close = false,
        layout = {
            preview = false,
            layout = {
                box = "vertical",
                width = 0,
                height = 0.4,
                position = "bottom",
                {
                    win = "input",
                    height = 1,
                    border = "bottom",
                },
                {
                    win = "list",
                    border = "none",
                },
            },
        },
        icons = {
            diagnostics = {
                Warn = "W",
                Error = "E",
                Hint = "H",
                Info = "I",
            },
        },
    },
    indent = {
        enabled = true,
        animate = {
            enabled = false,
        },
    },
})

vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>sg", Snacks.picker.grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>sb", Snacks.picker.lines, { desc = "Grep buffer lines" })
vim.keymap.set("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "Grep open buffers" })

vim.keymap.set("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Search diagnostics" })

-- :lsp

require("mason").setup()
require("fidget").setup({})
require("mason-lspconfig").setup()

local lsp_configs = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    },
}

for lsp, config in pairs(lsp_configs) do
    config.capabilities = require("blink.cmp").get_lsp_capabilities()
    vim.lsp.config(lsp, config)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client == nil then
            return
        end

        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename definition" })
        vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code actions" })
        vim.keymap.set("n", "grr", Snacks.picker.lsp_references, { buffer = event.buf, desc = "Lsp references" })
        vim.keymap.set(
            "n",
            "gri",
            Snacks.picker.lsp_implementations,
            { buffer = event.buf, desc = "Lsp implementations" }
        )
        vim.keymap.set("n", "grd", Snacks.picker.lsp_definitions, { buffer = event.buf, desc = "Lsp definitions" })
        vim.keymap.set("n", "grD", Snacks.picker.lsp_declarations, { buffer = event.buf, desc = "Lsp declarations" })

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                end,
            })
        end
    end,
})

-- :diagnostic

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "E",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
        },
    },
})

local diagnostic_augroup = vim.api.nvim_create_augroup("diagnostic-hover", {})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = diagnostic_augroup,
    callback = vim.diagnostic.open_float,
})

-- :completion

require("blink.cmp").setup({
    keymap = { preset = "default" },
    completion = {
        list = {
            selection = {
                preselect = false,
            },
        },
        menu = {
            draw = {
                treesitter = { "lsp " },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "lua",
    },
})

-- :treesitter

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "<filetype>" },
    callback = function()
        vim.treesitter.start()
    end,
})

-- :colorscheme

require("tokyonight").setup({
    style = "moon",
    transparent = true,
    plugins = {
        snacks = true,
        treesitter = true,
    },
})

vim.cmd.colorscheme("tokyonight")
