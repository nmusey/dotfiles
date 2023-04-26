local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = {
            i = function()
                if cmp.visible()
                then cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else cmp.complete()
                end
            end,
        },
        ['<C-k>'] = {
            i = function()
                if cmp.visible()
                then cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else cmp.complete()
                end
            end,
        },
        ['<C-l>'] = {
            i = cmp.mapping.confirm({ select = true })
        },
        ['<C-space>'] = {
            i = cmp.mapping.confirm({ select = true })
        },
        ['<C-h>'] = {
            i = cmp.mapping.abort()
        },
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'snippy' },
    }, {
      { name = 'buffer' },
    })
})
