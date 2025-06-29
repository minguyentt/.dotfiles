return {
	"folke/trouble.nvim",
	-- event = "VeryLazy",
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	config = function()
		require("trouble").setup()
	end,

	vim.keymap.set(
		"n",
		"<leader>tdp",
		"<cmd>Trouble diagnostics toggle<CR>",
		{ desc = "open diagnostics in current project" }
	),
	vim.keymap.set(
		"n",
		"<leader>td",
		"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
		{ desc = "open diagnostics in current buffer" }
	),
	vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix toggle<CR>", { desc = "open trouble quickfix list" }),
	vim.keymap.set(
		"n",
		"<leader>tl",
		"<cmd>Trouble lsp toggle focus=true win.type = split<cr>",
		{ desc = "open Trouble LSP definitions/references" }
	),
}
