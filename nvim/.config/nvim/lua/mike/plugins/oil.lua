return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            },
        }

        -- open parent directory in current window
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
