return {
    {
        "yetone/avante.nvim",
        build = "make",
        opts = {
            provider = "ollama",
            event = "VeryLazy",
            use_absolute_path = true,
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "qwen2.5-coder:7b-instruct",
                api_key_name="",
                stream = true,
            },
            cursor_applying_provider = "ollama",
            behaviour = {
                enable_cursor_planning_mode = false, 
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
            {
              'MeanderingProgrammer/render-markdown.nvim',
              opts = {
                file_types = { "markdown", "Avante" },
              },
              ft = { "markdown", "Avante" },
            },
        }
    },
}
