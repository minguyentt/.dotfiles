return {
    "kylechui/nvim-surround",
    enabled = false,
    event = "VeryLazy",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- config here or default
        })
    end
}
