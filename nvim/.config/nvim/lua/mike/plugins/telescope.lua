return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local layout = require("telescope.actions.layout")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-p>"] = layout.toggle_preview,
                        ["<C-d>"] = actions.delete_buffer,
                    },

                },
                preview = { hide_on_startup = true },
            },
            pickers = {
                lsp_references = { theme = "ivy" },
                find_files = { theme = "ivy", },
                grep_string = { theme = "ivy", },
                live_grep = { theme = "ivy", },
                buffers = { theme = "ivy", },
                diagnostics = { theme = "ivy", hide_on_startup = false },
                help_tags = { theme = "ivy", }
            }
        })

        vim.keymap.set("n", "<C-g>", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })

        vim.keymap.set("n", "<leader>gw", function()
            local curr_word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = curr_word })
        end, { desc = "Telescope grep word under cursor" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope git files" })

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope keymaps" })

        vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope help tags" })

        telescope.load_extension("fzf")
    end,
}
