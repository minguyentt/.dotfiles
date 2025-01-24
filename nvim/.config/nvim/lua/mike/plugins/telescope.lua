return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local layout = require("telescope.actions.layout")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-d>"] = actions.delete_buffer,
                        ["<C-p>"] = layout.toggle_preview,
                    },
                },
                preview = {
                    hide_on_startup = true, -- hide telescope preview
                }
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                },
                grep_string = {
                    theme = "dropdown",
                },
                live_grep = {
                    theme = "dropdown",
                },
                buffers = {
                    theme = "dropdown",
                },
                help_tags = {
                    theme = "dropdown",
                }
            }
        })

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Telescope grep string" })
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })

        telescope.load_extension("fzf")
    end,
}
