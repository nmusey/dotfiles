require('telescope').setup({
    defaults = {
        height = function () return math.min(_, _, max_lines * 0.9, 15),
        width = function () return math.min(_, _, max_lines * 0.9, 15),
    }
})
