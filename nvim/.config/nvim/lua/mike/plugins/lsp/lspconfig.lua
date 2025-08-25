return {
	"neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
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
	},

	config = function()
		local extend = function(name, key, values)
			local mod = require(string.format("lspconfig.configs.%s", name))
			local default = mod.default_config
			local keys = vim.split(key, ".", { plain = true })
			while #keys > 0 do
				local item = table.remove(keys, 1)
				default = default[item]
			end

			if vim.islist(default) then
				for _, value in ipairs(default) do
					table.insert(values, value)
				end
			else
				for item, value in pairs(default) do
					if not vim.tbl_contains(values, item) then
						values[item] = value
					end
				end
			end
			return values
		end

		local tools = {
			"gofumpt",
			"goimports",
			"gotests",
			"go-debug-adapter",

			"stylua",
			"prettierd",
			"eslint_d",
		}

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			gopls = {
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			},
			-- gopls = {},

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

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = tools,
		})

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = false,
			automatic_setup = false,
		})

		vim.list_extend(tools, servers_to_install)

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

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 }) -- show lsp definitions
				keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 }) -- show lsp definitions
				keymap.set("n", "grr", vim.lsp.buf.references, { buffer = 0 })
				keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })

                -- see available code actions, in visual mode will apply to selection
				keymap.set({ "n", "v" }, "<leader>cd", function()
					vim.lsp.buf.code_action()
				end)

                -- show diagnostics for line
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 })

                -- workspace diagnostics
				keymap.set("n", "<leader>wd", function()
					builtin.diagnostics(themes.get_dropdown())
				end, { buffer = 0 })

                -- show diagnostics for line
				keymap.set("n", "K", function()
					vim.lsp.buf.hover({
						max_width = 80,
						max_height = 50,
						border = "rounded",
					})
				end, { buffer = 0 })

				keymap.set("n", "<leader>h", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, { buffer = 0 })

				keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {})

				if settings.server_capabilities then
					for k, v in pairs(settings.server_capabilities) do
						if v == vim.NIL then
							---@diagnostic disable-next-line: cast-local-type
							v = nil
						end

						client.server_capabilities[k] = v
					end
				end
			end,
		})

		-- diagnostics
		vim.diagnostic.config({
			virtual_text = false,
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
				vim.diagnostic.config({ virtual_text = false })
			else
				vim.diagnostic.config({ virtual_text = true })
			end
		end, { desc = "Toggle lsp_lines" })
	end,
}
