vim.pack.add({

    "https://github.com/folke/tokyonight.nvim",

    -- editor
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/folke/snacks.nvim",

    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("plugins.config.lsp")
require("plugins.config.editor")
