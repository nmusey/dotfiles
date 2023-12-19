require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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
}
