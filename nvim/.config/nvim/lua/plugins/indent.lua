return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        require("ibl").setup({
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                char = "│",
                highlight = { "IBLScope" },
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help", "alpha", "dashboard", "neo-tree", "NvimTree",
                    "Trouble", "trouble", "lazy", "mason", "notify",
                    "toggleterm", "lazyterm",
                },
            },
        })

        local p = require('palette').get()
        -- Derive subtler shades by blending toward bg
        vim.api.nvim_set_hl(0, "IBLIndent", { fg = p.dark })
        vim.api.nvim_set_hl(0, "IBLScope",  { fg = p.muted })
    end,
}
