return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require('blame').setup({
                virtual_style = "right_align",
                relative_date_if_recent = false,
            })
        end,
    }
}
