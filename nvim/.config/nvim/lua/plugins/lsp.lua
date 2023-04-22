require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = {
        'bashls',
        'csharp_ls',
        'cssls',
        'docker_compose_language_service',
        'dockerls',
        'eslint',
        'gopls',
        'html',
        'intelephense',
        'jsonls',
        'lua_ls',
        'rust_analyzer',
        'sqlls',
        'tsserver',
    }
})

local telescope = require('telescope.builtin')
local on_lsp_attach = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gr', telescope.lsp_references, {})
end

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')


require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_lsp_attach,
            capabilities = lsp_capabilities,
        })
    end,
})