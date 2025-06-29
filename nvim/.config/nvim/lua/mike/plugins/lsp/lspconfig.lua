return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- lua lsp lazydev
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					"nvim-dap-ui",
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		-- formatter
		"stevearc/conform.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_lsp = require("cmp_nvim_lsp")

		local servers = {
			"lua_ls",
			"gopls",
			"ts_ls",
		}

		vim.lsp.config("gopls", {
			settings = {
				["gopls"] = {
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
		})

		local lsp_capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = lsp_capabilities,
			})
		end

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				--
				local opts = { buffer = ev.buf }

				opts.desc = "Show LSP references"
				keymap.set("n", "gr", vim.lsp.buf.references, opts)

				opts.desc = "open lsp definition in new tab"
				keymap.set("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts) -- show lsp definitions

				opts.desc = "jump to lsp definition"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>cd", function()
					vim.lsp.buf.code_action()
				end) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Show diagnostic under cursor"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			end,
		})

		-- diagnostics
		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				-- source = "always",
				header = "",
				prefix = "",
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
