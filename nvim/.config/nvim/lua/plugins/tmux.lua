return {
    "aserowy/tmux.nvim",
    setup = function()
        require("tmux").setup({
            copy_sync = {
                redirect_to_clipboard=true
            }
        }) 
    end
}
