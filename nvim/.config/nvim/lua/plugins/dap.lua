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

            -- Automaticall open DAPUI on breakpoints
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
            vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dp", "<cmd>lua require('dap').step_out()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').preview()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.open()()<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>dq", "<cmd>lua require('dap').repl.exit()()<CR>", { noremap = true })

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
