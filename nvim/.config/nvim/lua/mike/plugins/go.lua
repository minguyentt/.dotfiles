return {
	"ray-x/go.nvim",
    -- enabled = false,
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
    opts = {
        lsp_inlay_hints = {
            enable = false,
        },
        -- lsp_keymaps = false,

        -- dap_debug = false,
        dap_debug_keymap = false,
	},
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries

    vim.keymap.set("n", "<leader>tt", [[:GoTest -F -v]])
}
