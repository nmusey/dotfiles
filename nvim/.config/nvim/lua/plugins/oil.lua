return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "refractalize/oil-git-status.nvim",
        },
        config = function()
            require('oil').setup({
                view_options = {
                    show_hidden = true,
                    case_insensitive = true,
                },
                win_options = {
                    signcolumn = "yes:2",
                },
            })
        end,
    },
}
