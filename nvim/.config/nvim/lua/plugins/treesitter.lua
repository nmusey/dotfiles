return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require('nvim-treesitter-textobjects').setup({
                select = {
                    lookahead = true,
                }
            })

            local select = require('nvim-treesitter-textobjects.select')
            vim.keymap.set({'x', 'o'}, '<leader>fo', function() select.select_textobject('@function.outer', 'textobjects') end)
            vim.keymap.set({'x', 'o'}, '<leader>fi', function() select.select_textobject('@function.inner', 'textobjects') end)
            vim.keymap.set({'x', 'o'}, '<leader>co', function() select.select_textobject('@class.outer', 'textobjects') end)
            vim.keymap.set({'x', 'o'}, '<leader>ci', function() select.select_textobject('@class.inner', 'textobjects') end)

            local move = require('nvim-treesitter-textobjects.move')
            vim.keymap.set({'n', 'x', 'o'}, '<leader>fn', function() move.goto_next_start('@function.outer', 'textobjects') end)
            vim.keymap.set({'n', 'x', 'o'}, '<leader>fp', function() move.goto_previous_start('@function.outer', 'textobjects') end)

            local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        end,
    },
}
