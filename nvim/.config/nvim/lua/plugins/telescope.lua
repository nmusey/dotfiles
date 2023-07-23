local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Setup grep arguments for use in the config
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--trim")

require('telescope').setup{
	defaults = {
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {
            ".git/*",
            "**/.git/*",
        },
        color_devicons = true,
    },
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = true,
            follow = true,
        }
    },
 }
 
