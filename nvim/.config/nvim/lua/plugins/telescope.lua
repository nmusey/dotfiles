return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    mappings = {
                        n = {
                            ['<C-w'] = telescope.delete_buffer
                        },
                        i = {
                            ['<C-h>'] = 'which_key',
                            ['<C-w>'] = telescope.delete_buffer
                        }
                    },
                },
            })

            local pickers = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', pickers.find_files, {})
            vim.keymap.set('n', '<leader>fi', pickers.treesitter, {})
            vim.keymap.set('n', '<leader>fs', pickers.live_grep, {})
            vim.keymap.set('n', '<leader>bb', pickers.buffers, {})
            vim.keymap.set('n', '<leader>fc', pickers.grep_string, {})
            vim.keymap.set('n', '<leader>fm', pickers.marks, {})
            vim.keymap.set('n', '<leader>fri', pickers.lsp_incoming_calls, {})
            vim.keymap.set('n', '<leader>fro', pickers.lsp_outgoing_calls, {})
            vim.keymap.set('n', '<leader>fg', pickers.git_bcommits, {})
            vim.keymap.set('v', '<leader>fg', pickers.git_bcommits_range, {})
            vim.keymap.set('n', 'gr', pickers.lsp_references, {})
        end,
    }
}
