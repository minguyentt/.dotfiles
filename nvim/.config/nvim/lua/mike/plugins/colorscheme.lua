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
--         vim.cmd("colorscheme rose-pine")
--     end,
-- }

-- return {
-- 	"zenbones-theme/zenbones.nvim",
-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
-- 	dependencies = "rktjmp/lush.nvim",
-- 	lazy = false,
-- 	-- you can set set configuration options here
-- 	config = function()
-- 		-- vim.g.rosebones_darken_comments = 45
-- 		vim.g.zenbones_darken_comments = 45
-- 		-- vim.g.zenbones_darkness = 'warm'
-- 		vim.cmd.colorscheme('zenbones')
-- 		-- vim.cmd.colorscheme("rosebones")
-- 		vim.cmd([[ highlight Normal guibg=#000000 ]])
-- 	end,
-- }

-- asivlam theme
return {
    'asilvam133/rose-pine.nvim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
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

