return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	opts = {
		layouts = {
			{
				elements = {
					{ id = "console", size = 0.5 },
					{ id = "repl", size = 0.5 },
				},
				position = "left",
				size = 50,
			},
			{
				elements = {
					{ id = "scopes", size = 0.50 },
					{ id = "breakpoints", size = 0.20 },
					{ id = "stacks", size = 0.15 },
					{ id = "watches", size = 0.15 },
				},
				position = "bottom",
				size = 15,
			},
		},
	},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_go = require("dap-go")

        require("dapui").setup(opts)
		dap_go.setup()

		-- For One
		table.insert(dap.configurations.go, {
			type = "delveone",
			name = "CONTAINER 1 DEBUGGING",
			mode = "remote",
			request = "attach",
			substitutePath = {
				{ from = "/opt/homebrew/Cellar/go/1.23.1/libexec", to = "/usr/local/go" },
				{ from = "${workspaceFolder}", to = "/path/in/container" },
			},
		})

		-- For Two
		table.insert(dap.configurations.go, {
			type = "delvetwo",
			name = "CONTAINER 2 DEBUGGING",
			mode = "remote",
			request = "attach",
			substitutePath = {
				{ from = "/opt/homebrew/Cellar/go/1.23.1/libexec", to = "/usr/local/go" },
				{ from = "${workspaceFolder}", to = "/path/in/contianer" },
			},
		})

		-- adapters configuration
		dap.adapters.delveone = {
			type = "server",
			host = "127.0.0.1",
			port = "2345",
		}

		dap.adapters.delvetwo = {
			type = "server",
			host = "127.0.0.1",
			port = "2346",
		}

		-- java dab configs
		dap.configurations.java = {
			{
				name = "Debug Launch (2GB)",
				type = "java",
				request = "launch",
				vmArgs = "" .. "-Xmx2g",
			},
			{
				name = "Debug Launch (8000)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 8000,
			},
			{
				name = "Debug Launch (5005)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}


		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })

		vim.keymap.set("n", "<Leader>dr", dap.continue, { desc = "continue debugger" })
		vim.keymap.set("n", "<Leader>dR", dap.restart, { desc = "restart debugger session" })

		vim.keymap.set("n", "<Leader>de", function()
			require("dapui").eval()
		end, { desc = "eval debugger" })

		vim.keymap.set("n", "<Leader>do", function()
			require("dapui").open({ reset = true })
		end, { desc = "open debugger" })
		vim.keymap.set("n", "<Leader>dx", function()
			require("dapui").close()
		end, { desc = "close debugger" })

		vim.keymap.set("n", "<F1>", function()
			require("dap").step_into()
		end, { desc = "step into debugger" })
		vim.keymap.set("n", "<F2>", function()
			require("dap").step_over()
		end, { desc = "step over debugger" })
		vim.keymap.set("n", "<F3>", function()
			require("dap").step_out()
		end, { desc = "step out debugger" })
		vim.keymap.set("n", "<F4>", function()
			require("dap").step_back()
		end, { desc = "step back debugger" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
	end,
}
