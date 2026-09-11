return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "igorlfs/nvim-dap-view", version = "1.*"
            },
            "jay-babu/mason-nvim-dap.nvim",
            "mason-org/mason.nvim",
        },
        config = function()
            local dap = require("dap")

            require("dap-view").setup({
                auto_toggle = true,
            })

            -- Safe to call again even though lsp.lua also sets mason up.
            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })

            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "php", "js" },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    php = function(config)
                        config.configurations = {
                            {
                                type = "php",
                                request = "launch",
                                name = "Listen for Xdebug",
                                port = 9003,
                            },
                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    js = function(config)
                        for _, language in ipairs({ "javascript", "typescript" }) do
                            dap.configurations[language] = {
                                {
                                    type = "pwa-node",
                                    request = "launch",
                                    name = "Launch file",
                                    program = "${file}",
                                    cwd = "${workspaceFolder}",
                                },
                                {
                                    type = "pwa-node",
                                    request = "attach",
                                    name = "Attach to process",
                                    processId = require("dap.utils").pick_process,
                                    cwd = "${workspaceFolder}",
                                },
                            }
                        end
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticWarn" })

            local map = vim.keymap.set
            map("n", "<leader>xb", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
            map("n", "<leader>xB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "DAP: conditional breakpoint" })
            map("n", "<leader>xc", dap.continue, { desc = "DAP: continue / start" })
            map("n", "<leader>xo", dap.step_over, { desc = "DAP: step over" })
            map("n", "<leader>xi", dap.step_into, { desc = "DAP: step into" })
            map("n", "<leader>xu", dap.step_out, { desc = "DAP: step out" })
            map("n", "<leader>xr", dap.run_last, { desc = "DAP: run last" })
            map("n", "<leader>xt", dap.terminate, { desc = "DAP: terminate" })
            map("n", "<leader>xv", function()
                require("dap-view").toggle()
            end, { desc = "DAP: toggle dap-view UI" })
            map("n", "<leader>xe", function()
                require("dap-view").add_expr()
            end, { desc = "DAP: add watch expression" })
            map({ "n", "v" }, "<leader>xh", function()
                require("dap-view").hover()
            end, { desc = "DAP: hover value" })
        end,
    },
}
