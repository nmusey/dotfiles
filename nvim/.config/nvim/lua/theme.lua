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
local function pywal_theme()
    local wal_theme_file = vim.fn.expand("~/.cache/wal/colors-wal.vim")
    vim.cmd("source " .. wal_theme_file)
    vim.cmd.colorscheme("pywal16")
end

if not pcall(pywal_theme) then
    vim.cmd.colorscheme("gruvbox")
end

-- Reload theme when pywal regenerates its colours
if not _G._pywal_watcher then
    local uv = vim.uv or vim.loop
    _G._pywal_watcher = uv.new_fs_event()
    _G._pywal_watcher:start(
        vim.fn.expand("~/.cache/wal/colors-wal.vim"),
        {},
        vim.schedule_wrap(function()
            pcall(pywal_theme)
        end)
    )
end
