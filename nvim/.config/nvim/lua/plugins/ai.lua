return {
    {
        "yetone/avante.nvim",
        build = "make",
        opts = {
            provider = "ollama",
            event = "VeryLazy",
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "gemma3:4b",
            },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "hrsh7th/nvim-cmp",
            "ibhagwan/fzf-lua",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
        }
    },
}
