return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>fp",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
        {
            "<leader>fr",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
}
