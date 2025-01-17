return {
    "olexsmir/gopher.nvim",
    event = { "BufReadPre", "BufNewFile"},
    ft = "go",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function(opts)
        require("gopher").setup(opts)
    end,
    build = function()
        vim.cmd [[silent! GoInstallDeps]]
    end,
}
