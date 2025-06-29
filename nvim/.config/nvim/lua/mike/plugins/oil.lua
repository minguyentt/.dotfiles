return {
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
                winbar = "%{v:lua.CustomOil()}"
            },

			view_options = {
				show_hidden = false,
				-- natural_order = "fast",
				case_insensitive = false,

				is_hidden_file = function(name, _)
					local m = name:match("^%.")
					if name == '..' or name == '.env' then
						return false
					end

                    return m ~= nil
				end,
			},
			prompt_save_on_select_new_entry = true,
		})

		-- open parent directory in current window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
