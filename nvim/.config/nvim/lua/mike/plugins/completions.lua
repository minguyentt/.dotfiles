return {
	"hrsh7th/nvim-cmp",
	lazy = false,
	priority = 100,
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-buffer", -- source for text in buffer
		{
			"L3MON4D3/LuaSnip",
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		local kind_formatter = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				luasnip = "[snip]",
				buffer = "[buf]",
				path = "[path]",
			},
		})

		require("tailwindcss-colorizer-cmp").setup({
			color_sqaure_width = 2,
		})

		-- for documentation window highlight color
		vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#26233a" })

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			window = {
				documentation = {
					border = "rounded",
					winhighlight = "Normal:CmpNormal",
				},
			},
			-- completion = {
			-- 	completeopt = "menu,menuone,preview,noselect",
			-- },

			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					{ "i", "c" }
				),
				["<C-j>"] = cmp.mapping.select_next_item({
					behavior = cmp.ConfirmBehavior.Insert,
				}),
				["<C-k>"] = cmp.mapping.select_prev_item({
					behavior = cmp.ConfirmBehavior.Insert,
				}),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{
					name = "lazydev",
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				-- { name = "luasnip" }, -- snippets
				{ name = "path" },
				{ name = "buffer" }, -- text within current buffer
			}),

			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},

			---@diagnostic disable-next-line: missing-fields
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = function(entry, vim_item)
					-- Lspkind setup for icons
					vim_item = kind_formatter(entry, vim_item)

					-- Tailwind colorizer setup
					vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

					return vim_item
				end,
			},
		})

		-- Setup up vim-dadbod
		cmp.setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})
	end,
}
