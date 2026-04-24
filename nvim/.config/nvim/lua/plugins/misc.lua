return {
    "tpope/vim-commentary",
    "nvim-tree/nvim-web-devicons",
    "preservim/nerdtree",
    "machakann/vim-highlightedyank",
    "AckslD/nvim-neoclip.lua",

    -- Enhanced input/select dialogs (LSP rename, code actions, etc.)
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                default_prompt = "➤ ",
                win_options = { winblend = 0 },
            },
            select = {
                backend = { "telescope", "builtin" },
            },
        },
    },

    -- Inline hex color previews
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB      = true,
                RRGGBB   = true,
                names    = false,
                RRGGBBAA = true,
                css      = true,
            })
        end,
    },

    -- Styled TODO/FIXME/NOTE/HACK comment highlights
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local p = require('palette').get()
            require("todo-comments").setup({
                signs = true,
                keywords = {
                    FIX  = { icon = " ", color = p.pink },
                    TODO = { icon = " ", color = p.blue },
                    HACK = { icon = " ", color = p.yellow },
                    WARN = { icon = " ", color = p.yellow },
                    NOTE = { icon = " ", color = p.green },
                },
                highlight = {
                    before  = "",
                    keyword = "wide_fg",
                    after   = "fg",
                },
            })
        end,
    },
}
