return {
    "sainnhe/everforest",
    "morhetz/gruvbox",
    {
        "AlphaTechnolog/pywal.nvim",
        config = function()
            if io.open("~/.cache/wal/colors.vim" ,"r") ~= nil then
                require("pywal").setup()
                vim.cmd([[colorscheme pywal]])
            else
                vim.cmd([[colorscheme kanagawa]])
            end
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme kanagawa]])
        end
    },
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
