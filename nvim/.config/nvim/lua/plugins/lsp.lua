return {
    {
        "saghen/blink.cmp",
        dependencies = { "Saghen/blink.lib" },
        version = "1.*",
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    preset = "none",

                    ["<C-j>"] = { "select_next" },
                    ["<C-k>"] = { "select_prev" },
                    ["<C-l>"] = { "accept" },
                    ["<C-h>"] = { "cancel" },
                },

                completion = {
                    menu = {
                        auto_show = true,
                    },
                },

                sources = {
                    default = { "lsp", "path", "buffer", "snippets" },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local installed = {
                'lua_ls',
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion = {
                completionItem = {
                    snippetSupport = true,
                    resolveSupport = {
                        properties = {
                            'documentation',
                            'detail',
                            'additionalTextEdits',
                        },
                    },
                },
            }

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }
                vim.diagnostic.config({
                    virtual_text = true
                })

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, opts)
                vim.keymap.set('n', '<leader>nn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, opts)
            end

            vim.lsp.config('*', {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = installed,
            })

            vim.lsp.enable(installed)
        end,
    },
}
