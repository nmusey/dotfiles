return {
    {
        "williamboman/mason.nvim",
        opts = {
            automatic_installation = true,
            ui = {
                border = "rounded",
            },
            ignore = {
                "^node_modules$",
                "^%.git$",
                "^%.env$",
            }
        },
    },
    {
       "williamboman/mason-lspconfig.nvim", 
    },
}
