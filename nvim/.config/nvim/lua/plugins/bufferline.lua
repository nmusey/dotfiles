return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local p = require('palette').get()

        require("bufferline").setup({
            options = {
                mode = "buffers",
                separator_style = "slant",
                always_show_bufferline = false,
                show_buffer_close_icons = true,
                show_close_icon = false,
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = { error = " ", warning = " " }
                    local ret = {}
                    for k, v in pairs(diag) do
                        if icons[k] then ret[#ret + 1] = icons[k] .. v end
                    end
                    return table.concat(ret, " ")
                end,
                offsets = {
                    {
                        filetype   = "NvimTree",
                        text       = "Explorer",
                        highlight  = "Directory",
                        separator  = true,
                    },
                },
            },
            highlights = {
                fill                = { bg = p.bg },
                background          = { fg = p.muted, bg = p.bg_alt },
                tab                 = { fg = p.muted, bg = p.bg_alt },
                tab_selected        = { fg = p.fg,    bg = p.bg, bold = true },
                tab_separator       = { fg = p.bg,    bg = p.bg_alt },
                tab_separator_selected = { fg = p.bg, bg = p.bg },
                buffer_selected     = { fg = p.fg,    bg = p.bg,     bold = true, italic = false },
                buffer_visible      = { fg = p.muted, bg = p.bg_alt },
                close_button        = { fg = p.muted, bg = p.bg_alt },
                close_button_selected = { fg = p.muted, bg = p.bg },
                close_button_visible  = { fg = p.muted, bg = p.bg_alt },
                separator           = { fg = p.bg,    bg = p.bg_alt },
                separator_selected  = { fg = p.bg,    bg = p.bg },
                separator_visible   = { fg = p.bg,    bg = p.bg_alt },
                indicator_selected  = { fg = p.blue,  bg = p.bg },
                modified            = { fg = p.cyan,  bg = p.bg_alt },
                modified_selected   = { fg = p.cyan,  bg = p.bg },
                modified_visible    = { fg = p.cyan,  bg = p.bg_alt },
                duplicate_selected  = { fg = p.muted, bg = p.bg,     italic = true },
                duplicate_visible   = { fg = p.muted, bg = p.bg_alt, italic = true },
                duplicate           = { fg = p.muted, bg = p.bg_alt, italic = true },
                diagnostic          = { bg = p.bg_alt },
                diagnostic_selected = { bg = p.bg },
                diagnostic_visible  = { bg = p.bg_alt },
                error               = { fg = p.pink,   bg = p.bg_alt },
                error_selected      = { fg = p.pink,   bg = p.bg, bold = true },
                warning             = { fg = p.yellow, bg = p.bg_alt },
                warning_selected    = { fg = p.yellow, bg = p.bg, bold = true },
            },
        })
    end,
}
