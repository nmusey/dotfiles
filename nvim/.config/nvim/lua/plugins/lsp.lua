local on_attach = function(args)
    vim.diagnostic.config({
        virtual_text = true
    })

    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = args.bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {})
    vim.keymap.set('n', 'gr', telescope.lsp_references, {})
end

            
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local telescope = require('telescope.builtin')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local on_lsp_attach = on_attach
            local lspconfig = require('lspconfig')

            local get_intelephense_key = function()
                local f = io.open(os.getenv('HOME') .. '/intelephense/license.txt', 'rb')

                if f == nil then
                    return ''
                end

                local key = f:read('*a')
                f:close()
                return string.gsub(key, '%s+', '')
            end

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    if server_name == "intelephense" then
                        init_options = { licenceKey = get_intelephense_key() }
                    else
                        init_options = {}
                    end
                    lspconfig[server_name].setup({
                        on_attach = on_lsp_attach,
                        capabilities = lsp_capabilities,
                        init_options = init_options,
                    })
                end,
            })
        end
    },
    {
        "dundalek/lazy-lsp.nvim",
    },
}
