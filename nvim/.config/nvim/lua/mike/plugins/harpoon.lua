return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
        settings = {
            save_on_toggle = true,
        },
    },
    keys = function()
        local keys = {
            {
                "<leader>a",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "Harpoon File",
            },
            {
                "<C-e>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Quick Menu",
            },
            {
                "<C-q>",
                function()
                    local harpoon = require("harpoon")
                    harpoon:list():prev()
                end,
                desc = "harpoon prev file",
            },
            {
                "<C-p>",
                function()
                    local harpoon = require("harpoon")
                    harpoon:list():next()
                end,
                desc = "harpoon next file",
            },
        }

        for i = 1, 5 do
            table.insert(keys, {
                "<leader>" .. i,
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon to File " .. i,
            })
        end
        return keys
    end,
}
-- {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--     },
--     config = function()
--         local harpoon = require("harpoon")
--
--         -- REQUIRED
--         harpoon:setup()
--         -- REQUIRED
--
--         vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
--         vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--         vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
--         vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
--         vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
--         vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
--
--         -- Toggle previous & next buffers stored within Harpoon list
--         vim.keymap.set("n", "<C-q>", function() harpoon:list():prev() end)
--         vim.keymap.set("n", "<C-p>", function() harpoon:list():next() end)
--     end,
-- }
