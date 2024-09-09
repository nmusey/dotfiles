return {
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()

            vim.keymap.set("n", "<leader>cc", "<cmd>ChatGPT<CR>")
            vim.keymap.set("n", "<leader>ce", "<cmd>ChatGPTEditWithInstructions<CR>")
            vim.keymap.set("n", "<leader>ct", "<cmd>ChatGPTRun add_tests<CR>")
            vim.keymap.set("n", "<leader>cd", "<cmd>ChatGPTRun docstring<CR>")
            vim.keymap.set("n", "<leader>cs", "<cmd>ChatGPTRun fix_bugs<CR>")
            vim.keymap.set("n", "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>")
        end,    
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "folke/trouble.nvim",
          "nvim-telescope/telescope.nvim"
        },
    }
}
