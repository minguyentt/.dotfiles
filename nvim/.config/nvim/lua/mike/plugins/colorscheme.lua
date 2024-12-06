-- current theme: sublime lime text :)
-- return {
--     "ofirgall/ofirkai.nvim",
--     config = function()
--         require("ofirkai").setup({
--             theme = nil,
--             remove_italics = true,
--         })
--         vim.cmd("colorscheme ofirkai")
--         -- override eof
--         vim.cmd("highlight EndOfBuffer guifg=#fd971f")
--     end,
-- }

-- rose-pine
-- return {
--     "rose-pine/neovim",
--     config = function()
--         require("rose-pine").setup({
--             disable_italics = true,
--
--             highlight_groups = {
--                 CursorLine = { bg = "none" },
--                 Normal = { bg = "none" },
--                 NormalFloat = { bg = "none" }
--             }
--         })
--         -- vim.api.nvim_set_hl(0, '@keyword.function.go', { fg = '#7995AC' })
--         -- vim.api.nvim_set_hl(0, '@keyword.type.go', { fg = '#7995AC' })
--         -- vim.api.nvim_set_hl(0, '@keyword.return.go', { fg = '#7995AC' })
--         -- vim.api.nvim_set_hl(0, '@keyword.*.go', { fg = '#7995AC' })
--         vim.cmd("colorscheme rose-pine")
--     end,
-- }

-- asivlam theme
return {
    'asilvam133/rose-pine.nvim',
    name = 'rose-pine',
    lazy = false,
    opts = {
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },
        highlight_groups = {
            ['@keyword'] = { fg = '#7995AC' },             -- Basic keywords
            ['@keyword.function'] = { fg = '#7995AC' },    -- 'func' keyword
            ['@keyword.return'] = { fg = '#7995AC' },      -- 'return' keyword
            ['@keyword.type'] = { fg = '#7995AC' },        -- 'type' keyword
            ['@keyword.operator'] = { fg = '#7995AC' },    -- keyword operators
            ['@keyword.import'] = { fg = '#7995AC' },      -- 'import' keyword
            ['@keyword.storage'] = { fg = '#7995AC' },     -- 'const', 'var' keywords
            ['@keyword.repeat'] = { fg = '#7995AC' },      -- 'for', 'while' etc
            ['@keyword.conditional'] = { fg = '#7995AC' }, -- 'if', 'else' etc

            ['@function.builtin.lua'] = { italic = false },
            ['@lsp.type.comment'] = { italic = true },
            ['@lsp.typemod.function.defaultLibrary.lua'] = { italic = false },
            Comment = { italic = true },
            DiagnosticUnnecessary = { italic = false },
            TabLine = { bg = 'none' },
            TabLineSel = { bg = 'none' },
            TabLineFill = { bg = 'none' },
            ZenBg = { bg = 'none' },
        },
    },
    config = function(_, opts)
        require('rose-pine').setup(opts)
        vim.cmd("colorscheme rose-pine")
    end,
}
