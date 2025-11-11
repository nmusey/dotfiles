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
            dap.listeners.after.event_terminated["dapui_config"] = function()
              dapui.close()
            end
            dap.listeners.after.event_exited["dapui_config"] = function()
              dapui.close()
            end

            -- Keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true })
            vim.keymap.set("n", "<leader>dq", dap.close, { noremap = true })
            vim.keymap.set("n", "<leader>dn", dap.step_over, { noremap = true })
            vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true })
            vim.keymap.set("n", "<leader>do", dap.step_out, { noremap = true })
            vim.keymap.set("n", "<leader>dh", function() dap.ui.widgets.hover() end, { noremap = true })
            vim.keymap.set("n", "<leader>dp", function() dap.ui.widgets.preview() end, { noremap = true })
            vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { noremap = true })
            vim.keymap.set("n", "<leader>dx", function() dap.repl.exit() end, { noremap = true })
            vim.keymap.set("n", "<leader>dc", function()
                if dap.configurations.c and #dap.configurations.c == 1 then
                    dap.run(dap.configurations.c[1])
                else
                    dap.continue()
                end
            end, { noremap = true })

            -- Setup debuggers here
            dap.configurations.cs = dap.configurations.csharp
            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.adapters.cs = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = 'cs',
                    name = 'Launch - netcoredbg',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }

            dapui.setup()
        end
    }
}
