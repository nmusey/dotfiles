return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require('telescope')
            local sorters = require('telescope.sorters')

            local function extension_filter_sorter(opts)
                local base = sorters.get_fzy_sorter(opts)

                local function parse(prompt)
                    local name, ext = prompt:match('^(.-)  +(%S+)$')
                    if not ext then
                        return prompt, nil
                    end
                    return name, (ext:gsub('^%.', ''))
                end

                return sorters.Sorter:new({
                    scoring_function = function(_, prompt, line, entry, cb_add, cb_filter)
                        local name, ext = parse(prompt)
                        if ext then
                            local pattern = '%.' .. ext:lower():gsub('%p', '%%%1') .. '$'
                            if not line:lower():match(pattern) then
                                return -1
                            end
                        end
                        return base.scoring_function(base, name, line, entry, cb_add, cb_filter)
                    end,
                    highlighter = function(_, prompt, display)
                        local name = parse(prompt)
                        return base.highlighter(base, name, display)
                    end,
                })
            end

            telescope.setup({
                defaults = {
                    file_sorter = extension_filter_sorter,
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
