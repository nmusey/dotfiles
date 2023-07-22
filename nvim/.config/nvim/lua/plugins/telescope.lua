local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Setup grep arguments for use in the config
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--trim")

require('telescope').setup{
	defaults = {
        vimgrep_arguments = vimgrep_arguments,
    },
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
 }
 
require('telescope').load_extension('fzf')
