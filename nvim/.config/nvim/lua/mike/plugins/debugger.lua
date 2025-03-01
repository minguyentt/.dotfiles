return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.configurations.go = {
            {
                type = "go",
                name = "Debug",
                request = "launch",
                showLog = false,
                program = "${file}",
                dlvToolPath = vim.fn.exepath('dlv'),
                outputMode = "remote",
            }
        }

        require("dapui").setup()
        require("dap-go").setup()

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

        vim.keymap.set("n", "<F1>", function() require('dap').step_into() end, { desc = "step into debugger" })
        vim.keymap.set("n", "<F2>", function() require('dap').step_over() end, { desc = "step over debugger" })
        vim.keymap.set("n", "<F3>", function() require('dap').step_out() end, { desc = "step out debugger" })
        vim.keymap.set("n", "<F4>", function() require('dap').step_back() end, { desc = "step back debugger" })

        vim.keymap.set("n", "<Leader>de", function() require('dapui').eval() end, { desc = "eval debugger" })

        vim.keymap.set("n", "<Leader>dd", function() require('dapui').open({ reset = true }) end)
        vim.keymap.set("n", "<Leader>dc", function() require('dapui').close() end)

        vim.fn.sign_define(
            "DapBreakpoint",
            { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
        )
    end,
}
