return {
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
}
