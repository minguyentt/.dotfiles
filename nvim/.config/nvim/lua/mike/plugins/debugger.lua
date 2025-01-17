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

        vim.keymap.set("n", "<Leader>bt", ":DapUiToggle<CR>", {})
        vim.keymap.set("n", "<Leader>bp", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>br", dap.continue, {})

        vim.keymap.set("n", "<Leader>bi", function() require('dap').step_into() end)
        vim.keymap.set("n", "<Leader>be", function() require('dapui').eval() end)

        vim.keymap.set("n", "<Leader>bb", function() require('dapui').open({ reset = true }) end)
        vim.keymap.set("n", "<Leader>bc", function() require('dapui').close() end)

        vim.fn.sign_define(
            "DapBreakpoint",
            { text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
        )
    end,
}
