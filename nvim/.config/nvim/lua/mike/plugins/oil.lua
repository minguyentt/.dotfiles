return {
	{
		"echasnovski/mini.icons",
		version = "*",
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			CustomOil = function()
				local path = vim.fn.expand("%")
				path = path:gsub("oil://", "")
				return " " .. vim.fn.fnamemodify(path, ":.")
			end

			require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = true,
				columns = { "icon" },

				win_options = {
					winbar = "%{v:lua.CustomOil()}",
				},
				lsp_file_methods = {
					enabled = true,
					timeout_ms = 1000,
					autosave_changes = "unmodified",
				},

				watch_for_changes = true,

				view_options = {
					show_hidden = false,
					natural_order = "fast",
					case_insensitive = false,

					is_hidden_file = function(name, _)
						local m = name:match("^%.")
						if name == ".." or name == ".env" then
							return false
						end

						return m ~= nil
					end,
				},
			})

			-- open parent directory in current window
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
		end,
	},
}
