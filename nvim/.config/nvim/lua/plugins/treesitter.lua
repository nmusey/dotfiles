return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = 'all',
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = {'*'}
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gu",
                        node_incremental = "gnu",
                        scope_incremental = "gsu",
                        node_decremental = "gnd",
                    }
                },
                indent = {
                    enable = true
                },
                textobjects = {
                    select = {
                        enable = true,
                        include_surrounding_whitespace = true,
                        lookahead = true,

                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['as'] = '@scope.outer',
                            ['is'] = '@scope.inner',
                        }
                    },
                    move = {
                        enable = true,
                        goto_previous_start = {
                            ['<leader>fp'] = '@function.outer'
                        },
                        goto_next_start = {
                            ['<leader>fn'] = '@function.outer'
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ['<leader>gh'] = '@function.outer',
                        },
                    },
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    }
}
