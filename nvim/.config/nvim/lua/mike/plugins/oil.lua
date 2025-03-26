return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("oil").setup {
            default_file_explorer = true,
            delete_to_trash = true,
            columns = { "icon" },
            view_options = {
                show_hidden = true,
                natural_order = "fast",
                case_insensitive = false,
                is_always_hidden = function(file, _)
                    return file == '.git'
                end,
            },
            prompt_save_on_select_new_entry = true,
        }

        -- open parent directory in current window
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
