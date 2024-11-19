return {
		"nvim-treesitter/nvim-treesitter",
		-- event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
             "nvim-treesitter/nvim-treesitter-textobjects"
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({
             modules = {},
             ignore_install = {},
				-- ensure these language parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"yaml",
					"html",
					"css",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "java",
				},
                sync_install = false,
                auto_install = true,

          -- enable syntax highlighting
				highlight = {
				    enable = true,
                    additional_vim_regex_highlighting = false
                },

				-- enable indentation
				indent = { enable = true },

				-- enable autotagging (w/ nvim-ts-autotag plugin)
			-- 	autotag = {
			-- 		enable = true,
			-- 	},
			-- 	incremental_selection = {
			-- 		enable = true,
			-- 		keymaps = {
			-- 			init_selection = "<C-space>",
			-- 			node_incremental = "<C-space>",
			-- 			scope_incremental = false,
			-- 			node_decremental = "<bs>",
			-- 		},
			-- 	},
			})
		end,
}
