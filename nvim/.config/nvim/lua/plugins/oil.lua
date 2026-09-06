return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-mini/mini.icons",
        },
        lazy = false,
        config = function()
            require('oil').setup({
                columns = {
                    "icon",
                    "permissions",
                    "size",
                },
                skip_confirm_for_simple_edits = true,
                prompt_save_on_select_new_entry = false,
                watch_for_changes = true,
                default_file_explorer = true,
                view_options = {
                    show_hidden = true,
                    case_insensitive = true,
                },
                win_options = {
                    signcolumn = "yes:2",
                },
            })
        end,
        keymaps = {
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    Detail = not Detail
                    if Detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
        }
    },
    {
        "refractalize/oil-git-status.nvim",
        dependencies = {
            "stevearc/oil.nvim",
        },
        config = function ()
            require('oil-git-status').setup({})
        end
    },
}
