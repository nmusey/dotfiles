vim.g.mapleader = ' '

-- LSP keybinds are in plugins/lsp.lua in the on_lsp_attach function

-- Tab Management
vim.keymap.set('n', '<leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader>T', '<cmd>tab split<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>tabp<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>tabn<CR>')
vim.keymap.set('n', '<leader>J', '<cmd>tabm -<CR>')
vim.keymap.set('n', '<leader>K', '<cmd>tabm +<CR>')

-- Panes
vim.keymap.set('', '<leader>Y', '<cmd>vsplit<CR>')
vim.keymap.set('', '<leader>U', '<cmd>split<CR>')

-- Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank/Paste/Delete Settings
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Navigation
vim.keymap.set('', '<leader>ft', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('', '<leader>ff', '<cmd>NERDTreeFocus<CR>')
vim.keymap.set('', '<leader>ffc', '<cmd>NERDTreeFind<CR>')

-- Telescope
local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s', telescope.find_files, {})
vim.keymap.set('n', '<leader>S', telescope.treesitter, {})
vim.keymap.set('n', '<leader>r', telescope.grep_string, {})
vim.keymap.set('n', '<leader>R', telescope.git_files, {})

-- Git
vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>GitGutterPreviewHunk<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>GitGutterNextHunk<CR>')
vim.keymap.set('n', '<leader>gN', '<cmd>GitGutterPrevHunk<CR>')
vim.keymap.set('n', '<leader>gr', '<cmd>GitGutterRevertHunk<CR>')

-- Copilot
vim.keymap.set('i', '<C-.>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-,>', '<Plug>(copilot-previous)')
