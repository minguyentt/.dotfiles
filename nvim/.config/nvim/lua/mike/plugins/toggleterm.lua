return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		close_on_exit = false,
		autochdir = true,
		shell = vim.o.shell,
		size = 20,
	},
	keys = {
		{ "<C-t>", "<cmd>ToggleTerm size=15 direction=horizontal<cr>" },
	},
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]]),
	vim.keymap.set("t", "<c-h>", [[<cmd>wincmd h<cr>]]),
	vim.keymap.set("t", "<c-j>", [[<cmd>wincmd j<cr>]]),
	vim.keymap.set("t", "<c-k>", [[<cmd>wincmd k<cr>]]),
	vim.keymap.set("t", "<c-l>", [[<cmd>wincmd l<cr>]]),
	vim.keymap.set("t", "<c-w>", [[<c-\><c-n><c-w>]]),
}
