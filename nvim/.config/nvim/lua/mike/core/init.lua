require("mike.core.options")
require("mike.core.keymaps")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local flowstate_group = augroup('flowstate_group', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = flowstate_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

