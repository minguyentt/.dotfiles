return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/nvim-cmp",
		-- lua lsp lazydev
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"b0o/SchemaStore.nvim",

		-- Autoformatting
		"stevearc/conform.nvim",

		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

		-- LSP notification UI
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
	},

	config = function()
		local tools = {
			"stylua",
			"gofumpt",
			"goimports",
			"gci",
			"prettierd",
			"go-debug-adapter",
			"eslint_d",
		}

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
							},
						},

						completion = {
							callSnippet = "Replace",
							enable = true,
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},

			-- gopls = {
			-- 	settings = {
			-- 		gopls = {
			-- 			hints = {
			-- 				assignVariableTypes = true,
			-- 				compositeLiteralFields = true,
			-- 				compositeLiteralTypes = true,
			-- 				constantValues = true,
			-- 				functionTypeParameters = true,
			-- 				parameterNames = true,
			-- 				rangeVariableTypes = true,
			-- 			},
			-- 		},
			-- 	},
			-- },
            gopls = {},

			ts_ls = {},
			jdtls = {},

			jsonls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},

			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
					},
				},
			},

			tailwindcss = {},
			dockerls = {},
		}

		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = tools,
		})

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for server, config in pairs(servers) do
			vim.tbl_deep_extend("force", {}, {
				capabilities = capabilities,
			}, config)

			vim.lsp.config(server, config)
		end

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local themes = require("telescope.themes")
				local builtin = require("telescope.builtin")

				keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 }) -- show lsp definitions
				keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 }) -- show lsp definitions
				keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
				keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
				keymap.set({ "n", "v" }, "<leader>cd", function() vim.lsp.buf.code_action() end) -- see available code actions, in visual mode will apply to selection
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 }) -- show diagnostics for line
				keymap.set("n", "<leader>dd", function() builtin.diagnostics(themes.get_dropdown()) end, { buffer = 0 }) -- show diagnostics for line

				keymap.set("n", "K", function()
					vim.lsp.buf.hover({
						max_width = 80,
						max_height = 50,
						border = "rounded",
					})
				end, { buffer = 0 }) -- show documentation for what is under cursor

				keymap.set("n", "<leader>h", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, { buffer = 0 })

				keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {})
			end,
		})

		-- diagnostics
		vim.diagnostic.config({
			update_in_insert = false,
			virtual_text = true,
			virtual_lines = false,

			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
		})

		vim.keymap.set("", "<leader>l", function()
			local config = vim.diagnostic.config() or {}
			if config.virtual_text then
				vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
			else
				vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
			end
		end, { desc = "Toggle lsp_lines" })
	end,
}
