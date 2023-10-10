require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true,
})

local telescope = require('telescope.builtin')
local on_lsp_attach = function(args)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = args.bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {})
    vim.keymap.set('n', 'gr', telescope.lsp_references, {})
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
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
