return {
    "sainnhe/everforest",
    "morhetz/gruvbox",
    "rebelot/kanagawa.nvim",
    'uZer/pywal16.nvim',
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local startify = require("alpha.themes.dashboard")
            startify.file_icons = "devtools"
            require("alpha").setup(startify.config)
        end,
    },
}
