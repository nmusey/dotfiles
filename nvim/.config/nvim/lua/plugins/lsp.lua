return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local telescope = require('telescope.builtin')
            local on_lsp_attach = function(args)
                vim.diagnostic.config({
                    virtual_text = true
                })

                vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = args.bufnr })
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {})
                vim.keymap.set('n', 'gr', telescope.lsp_references, {})
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
                vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
                vim.keymap.set('n', '<leader>nn', vim.lsp.buf.rename, {})
                vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
                vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev)
                vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next)
            end

            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            vim.lsp.config("roslyn", {
                on_attach = on_lsp_attach,
                capabilities = lsp_capabilities,
            })

            vim.lsp.enable("roslyn")

            -- vim.lsp.config("roslyn", {
            --     on_attach = function()
            --     end,
            --     settings = {
            --         ["csharp|inlay_hints"] = {
            --             csharp_enable_inlay_hints_for_implicit_object_creation = true,
            --             csharp_enable_inlay_hints_for_implicit_variable_types = true,
            --         },
            --         ["csharp|code_lens"] = {
            --             dotnet_enable_references_code_lens = true,
            --         },
            --     },
            -- })

            -- local get_intelephense_key = function()
            --     local f = io.open(os.getenv('HOME') .. '/.intelephense/license.txt', 'rb')

            --     if f == nil then
            --         return ''
            --     end

            --     local key = f:read('*a')
            --     f:close()
            --     return string.gsub(key, '%s+', '')
            -- end
        end
    },
    {
        "dundalek/lazy-lsp.nvim",
    },
}
