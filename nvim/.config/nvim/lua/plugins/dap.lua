return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

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

            -- Keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true })
            vim.keymap.set("n", "<leader>dq", dap.close, { noremap = true })
            vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true })
            vim.keymap.set("n", "<leader>dn", dap.step_over, { noremap = true })
            vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true })
            vim.keymap.set("n", "<leader>do", dap.step_out, { noremap = true })
            vim.keymap.set("n", "<leader>dh", function() dapui.hover() end, { noremap = true })
            vim.keymap.set("n", "<leader>dh", function() dapui.preview() end, { noremap = true })
            vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { noremap = true })
            vim.keymap.set("n", "<leader>dx", function() dap.repl.exit() end, { noremap = true })

            -- Setup debuggers here
            require("dap-go").setup()

            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" }
            }

            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9000,
                    pathMappings = {
                        ["/var/www/html"] = "${workspaceFolder}"
                    }
                }
            }

            dapui.setup()
        end
    }
}
