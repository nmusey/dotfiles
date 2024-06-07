return {
    "mfussenegger/nvim-lint",
    config = function()
        local linter = require("lint")
        linter.linters_by_ft = {
            markdown = {"vale"},
        }
    end
}
