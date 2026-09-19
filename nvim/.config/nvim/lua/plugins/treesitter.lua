return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = 'master',
        opts = {
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
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
            vim.keymap.set({ 'x', 'o' }, 'of', function() select.select_textobject('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'oc', function() select.select_textobject('@class.outer', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

            local move = require('nvim-treesitter-textobjects.move')
            vim.keymap.set({ 'n', 'x', 'o' }, 'fn', function() move.goto_next_start('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, 'fp',
                function() move.goto_previous_start('@function.outer', 'textobjects') end)

            local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
}
