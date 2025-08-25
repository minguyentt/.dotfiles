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
                "<C-m>",
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
                "<C-n>",
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
