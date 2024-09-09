 return {
     "nvim-telescope/telescope-ui-select.nvim",
     {
        "nvim-telescope/telescope.nvim",
        dependencies = {
             "nvim-lua/plenary.nvim",
             "nvim-lua/popup.nvim",
             "kyazdani42/nvim-web-devicons",
        },
        config = function()
            local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
            table.insert(vimgrep_arguments, "--hidden")
            table.insert(vimgrep_arguments, "--trim")

            require('telescope').setup{
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                    file_ignore_patterns = {
                         ".git",
                         "**/.git",
                         "node_modules",
                         "**/node_modules",
                         "vendor",
                         "**/vendor"
                    },
                    color_devicons = true,
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown({
                            winblend = 10,
                            border = true,
                            previewer = false,
                            shorten_path = false,
                        }),
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        follow = true,
                    }
                },
            }

            require('telescope').load_extension('ui-select')
        end,
    }
}
