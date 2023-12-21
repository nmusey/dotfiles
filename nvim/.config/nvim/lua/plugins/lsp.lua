local mason_config = require('mason-lspconfig')

require('mason').setup()
mason_config.setup({
    automatic_installation = true,
})

local telescope = require('telescope.builtin')
local on_lsp_attach = function(args)
    vim.diagnostic.config({
        virtual_text = true
    })

    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = args.bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {})
    vim.keymap.set('n', 'gr', telescope.lsp_references, {})
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next)
end

local lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    local f = assert(io.open(os.getenv('HOME') .. '/intelephense/license.txt'), 'rb')
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
