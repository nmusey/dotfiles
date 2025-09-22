return {
    "github/copilot.vim",
    {
        "olimorris/codecompanion.nvim",
        config = function()
            local companion = require("codecompanion")
            companion.setup({
            strategies = {
                code = {
                    provider = "copilot",
                },
                chat = {
                    provider = "copilot",
                },
                inline = {
                    provider = "copilot",
                },
            },
        })

        vim.keymap.set({"n", "v"}, "<leader>ai", function() companion.generate() end)
        end,
    }
}
