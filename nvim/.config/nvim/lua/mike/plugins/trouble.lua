return {
    "folke/trouble.nvim",
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>df", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Open trouble workspace diagnostics" },
        { "<leader>tt", "<cmd>Trouble qflist toggle<CR>",                   desc = "Open trouble quickfix list" },
        { "<leader>tl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Open trouble location list" },
        {
            "<leader>tda",
            "<cmd>Trouble lsp toggle win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
    },
}
