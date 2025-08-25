return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    -- tag = '0.1.8',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local layout = require("telescope.actions.layout")
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")

        local opts = {
            layout_config = { width = 0.5 }
        }

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
        })

        vim.keymap.set("n", "<C-g>g", function() builtin.live_grep(themes.get_dropdown(opts)) end)
        vim.keymap.set("n", "<C-g>b", function() builtin.buffers(themes.get_dropdown(opts)) end)

        vim.keymap.set("n", "<leader>gw", function()
            local curr_word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = curr_word }, themes.get_dropdown(opts))
        end, { desc = "Telescope grep word under cursor" })

        vim.keymap.set("n", "<leader>ff", function() builtin.find_files(themes.get_dropdown(opts)) end)

        -- vim.keymap.set("n", "<leader>fd", function()
        --     local base = "./"
        --     local dir = vim.fn.input("find_dir > ")
        --
        --     builtin.find_files({ search_dirs = {
        --         vim.fn.expand('%:h'), base .. dir }
        --     })
        -- end, { desc = "find files within specified directory"})

        vim.keymap.set("n", "<leader>k", function() builtin.keymaps(themes.get_dropdown(opts)) end)
        vim.keymap.set("n", "<leader>ht", function() builtin.help_tags() end)

        telescope.load_extension("fzf")
    end,
}
