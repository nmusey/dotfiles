local on_attach = function(args)
    vim.diagnostic.config({
        virtual_text = true
    })
end

            
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local telescope = require('telescope.builtin')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local on_lsp_attach = on_attach
            local lspconfig = require('lspconfig')

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = on_lsp_attach,
                        capabilities = lsp_capabilities,
                    })
                end,
            })

            local get_intelephense_key = function()
                local f = io.open(os.getenv('HOME') .. '/intelephense/license.txt', 'rb')

                if f == nil then
                    return ''
                end

                local key = f:read('*a')
                f:close()
                return string.gsub(key, '%s+', '')
            end

            lspconfig.intelephense.setup({
                on_attach = on_lsp_attach,
                capabilities = lsp_capabilities,
                init_options = {
                    licenceKey = get_intelephense_key()
                }
            })
        end
    },
    {
        "dundalek/lazy-lsp.nvim",
    },
}
