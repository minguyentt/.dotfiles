return {
    "stevearc/conform.nvim",
    lazy = true,
    -- event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    event = { "BufWritePre" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                lua = { "lua-format" },
                -- go = { "gofumpt", "goimports", "golines" }
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                async = true,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
