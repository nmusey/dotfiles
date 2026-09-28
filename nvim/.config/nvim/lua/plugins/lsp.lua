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
            local installed = {}
            for _, dir in ipairs({ '/lsp/*.lua', '/after/lsp/*.lua' }) do
                for _, file in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. dir, false, true)) do
                    local name = vim.fn.fnamemodify(file, ':t:r')
                    if not vim.tbl_contains(installed, name) then
                        table.insert(installed, name)
                    end
                end
            end

            local system_servers = {
                roslyn_ls = 'Microsoft.CodeAnalysis.LanguageServer',
            }
            local mason_servers = vim.tbl_filter(function(name)
                local bin = system_servers[name]
                return not (bin and vim.fn.executable(bin) == 1)
            end, installed)

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

            local on_attach = function(args)
                local opts = { buffer = args.buf, silent = true }
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

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('user.lsp', { clear = true }),
                callback = on_attach,
            })

            vim.lsp.config('*', {
                capabilities = capabilities,
            })

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = mason_servers,
            })

            vim.lsp.enable(installed)
        end,
    },
}
