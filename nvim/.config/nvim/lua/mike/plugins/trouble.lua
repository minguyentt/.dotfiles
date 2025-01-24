return {
    "folke/trouble.nvim",
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Open trouble workspace diagnostics" },
        { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
        { "<leader>tq", "<cmd>Trouble qflist toggle<CR>",                   desc = "Open trouble quickfix list" },
        { "<leader>tl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Open trouble location list" },
    },
}
