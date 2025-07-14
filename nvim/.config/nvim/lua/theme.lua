-- Theme
vim.opt.termguicolors = true
vim.opt.background = 'dark'


-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- Line Numbers
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true

-- Navigation
vim.opt.mouse = 'a'
vim.opt.scrolloff = 32

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Miscellaneous
vim.opt.clipboard = 'unnamedplus'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true

vim.opt.swapfile = false
            
-- Theme setup
function pywal_theme()
    local wal_theme_file = vim.fn.expand("~/.cache/wal/colors-wal.vim")
    vim.cmd("source " .. wal_theme_file)
    vim.cmd.colorscheme("pywal16")
end

if not pcall(pywal_theme) then
    local default_theme = "gruvbox"
    vim.cmd.colorscheme(default_theme)
end
