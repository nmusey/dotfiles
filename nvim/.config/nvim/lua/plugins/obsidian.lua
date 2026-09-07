return {
    {
        'obsidian-nvim/obsidian.nvim',
        config = function()
            require('obsidian').setup({
                legacy_commands = false,
                workspaces = {
                    {
                        name = 'vault',
                        path = os.getenv('VAULT_LOCATION') or '~/Documents/nick-vault',
                    }
                },
                daily_notes = {
                    enabled = true,
                    folder = "daily",
                    date_format = "YYYY-MM-DD",
                    template = "templates/{{ date }}.md"
                },
            })

            vim.keymap.set('n', '<leader>od', '<cmd>Obsidian today<CR>')
        end
    }, {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require('markview').setup()

            local function fix_code_contrast()
                vim.api.nvim_set_hl(0, 'MarkviewCode', { bg = '#2a2f3d' })
                vim.api.nvim_set_hl(0, 'MarkviewCodeInfo', { bg = '#2a2f3d', fg = '#8b93a7' })
                vim.api.nvim_set_hl(0, 'MarkviewInlineCode', { bg = '#333a4d', fg = '#d5deff' })
            end

            fix_code_contrast()
            vim.api.nvim_create_autocmd('ColorScheme', {
                desc = 'Keep markview code blocks readable',
                callback = fix_code_contrast,
            })
        end,
    }
}
