
vim.pack.add({

    -- colorscheme
    "https://github.com/folke/tokyonight.nvim",

    -- file
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/stevearc/conform.nvim",

    -- picker
    "https://github.com/folke/snacks.nvim",

    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

    "https://github.com/j-hui/fidget.nvim",

    -- completion
    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets",

    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" }
})

require("plugins.editorconfig").setup()
