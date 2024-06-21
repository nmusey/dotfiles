return {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        local noice = require("noice")


        noice.setup({
            cmdline = {
                enabled = true,
                view = 'cmdline_popup',
            },
            presets = {
                command_palette = true,
                long_message_to_split = true,
                lsp_doc_border = true
            }
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}
