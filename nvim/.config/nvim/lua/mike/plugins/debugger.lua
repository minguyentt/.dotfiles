return {
    "mfussenegger/nvim-dap",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
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

        vim.keymap.set("n", "<Leader>dt", ":DapUiToggle<CR>", { desc = "toggle debugger ui" })
        vim.keymap.set("n", "<Leader>dp", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
        vim.keymap.set("n", "<Leader>dr", dap.continue, { desc = "continue debugger" })

        vim.keymap.set("n", "<Leader>bi", function() require('dap').step_into() end)
        vim.keymap.set("n", "<Leader>be", function() require('dapui').eval() end)

        vim.keymap.set("n", "<Leader>dd", function() require('dapui').open({ reset = true }) end)
        vim.keymap.set("n", "<Leader>dc", function() require('dapui').close() end)

        vim.fn.sign_define(
            "DapBreakpoint",
            { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
        )
    end,
}
