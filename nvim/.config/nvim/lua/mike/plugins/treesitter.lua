return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({
            modules = {},
            ignore_install = {},
            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "yaml",
                "html",
                "css",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "go",
                "java",
                "make",
                "templ",
            },
            sync_install = false,
            auto_install = true,

            -- enable syntax highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },

            -- enable indentation
            indent = { enable = true },
        })
    end,
}
