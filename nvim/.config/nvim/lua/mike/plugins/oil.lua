return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("oil").setup {
            delete_to_trash = true,
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            },
        }

        -- open parent directory in current window
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
