return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<leader>mv", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<leader>mh", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<leader>mt", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
          end,
        })

        vim.keymap.set("n", "<leader>ma", function() harpoon:list():append() end)
        vim.keymap.set("n", "<leader>mr", function() harpoon:list():remove() end)
        vim.keymap.set("n", "<leader>mc", function() harpoon:list():clear() end)

        vim.keymap.set("n", "<leader>mm", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

        vim.keymap.set("n", "<leader>mp", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader>mn", function() harpoon:list():next() end) 
    end
}
