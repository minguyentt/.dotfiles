require("mike.core.options")
require("mike.core.keymaps")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

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

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {}),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
        vim.bo.filetype = "terminal"
    end,
})

vim.keymap.set("n", "<leader>st", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 15)
    vim.cmd.term()
end)

vim.keymap.set("t", "<C-c>", "<C-\\><C-N>")
