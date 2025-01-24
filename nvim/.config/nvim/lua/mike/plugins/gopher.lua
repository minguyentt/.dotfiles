return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(opts)
        require("gopher").setup(opts)
    end,
    build = function()
        -- vim.cmd [[silent! GoInstallDeps]]
        vim.cmd.GoInstallDeps()
    end,
}
