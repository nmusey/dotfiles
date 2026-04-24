return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local p = require('palette').get()

        local theme = {
            normal = {
                a = { fg = p.bg,    bg = p.blue,   gui = "bold" },
                b = { fg = p.cyan,  bg = p.bg_alt },
                c = { fg = p.muted, bg = p.bg },
            },
            insert = {
                a = { fg = p.bg,    bg = p.green,  gui = "bold" },
                b = { fg = p.green, bg = p.bg_alt },
                c = { fg = p.muted, bg = p.bg },
            },
            visual = {
                a = { fg = p.bg,    bg = p.pink,   gui = "bold" },
                b = { fg = p.pink,  bg = p.bg_alt },
                c = { fg = p.muted, bg = p.bg },
            },
            replace = {
                a = { fg = p.bg,    bg = p.pink,   gui = "bold" },
                b = { fg = p.muted, bg = p.bg_alt },
                c = { fg = p.muted, bg = p.bg },
            },
            command = {
                a = { fg = p.bg,    bg = p.cyan,   gui = "bold" },
                b = { fg = p.muted, bg = p.bg_alt },
                c = { fg = p.muted, bg = p.bg },
            },
            inactive = {
                a = { fg = p.muted, bg = p.bg },
                b = { fg = p.muted, bg = p.bg },
                c = { fg = p.muted, bg = p.bg },
            },
        }

        require("lualine").setup({
            options = {
                theme = theme,
                component_separators = { left = "", right = "" },
                section_separators   = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch", icon = "" },
                    { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                },
                lualine_c = {
                    { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[No Name]" } },
                },
                lualine_x = {
                    { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " ", hint = " " } },
                    "encoding",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "location" },
            },
        })
    end,
}
