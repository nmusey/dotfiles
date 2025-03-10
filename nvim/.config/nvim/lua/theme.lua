-- Theme
vim.opt.termguicolors = false
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
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
