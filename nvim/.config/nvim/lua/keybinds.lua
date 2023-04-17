vim.g.mapleader = ' '

-- Tab Management
vim.keymap.set('', '<leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('', '<leader>j', '<cmd>tabp<CR>')
vim.keymap.set('', '<leader>k', '<cmd>tabn<CR>')
vim.keymap.set('', '<leader>J', '<cmd>tabm -<CR>')
vim.keymap.set('', '<leader>K', '<cmd>tabm +<CR>')

-- Panes
vim.keymap.set('', '<leader>Y', '<cmd>vsplit<CR>')
vim.keymap.set('', '<leader>U', '<cmd>split<CR>')

-- Navigation
vim.keymap.set('', '<leader>ft', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('', '<leader>ff', '<cmd>NERDTreeFocus<CR>')
vim.keymap.set('', '<leader>ffc', '<cmd>NERDTreeFind<CR>')
vim.keymap.set('', '<leader>r', '<cmd>grep<CR>')
vim.keymap.set('', '<leader>R', '<cmd>grep <C-r><C-w><CR>')
vim.keymap.set('', '<leader>s', '<cmd>Files<CR>')

-- LSP 
vim.keymap.set('n', '<silent>gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<silent>gr', ':lua vim.lsp.buf.references()<CR>')

-- Telescope
telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s', telescope.find_files, {})
vim.keymap.set('n', '<leader>r', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fg', telescope.git_files, {})

-- Git
vim.keymap.set('n', '<leader>g', '<cmd>GitGutterPreviewHunk<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>GitGutterNextHunk<CR>')
vim.keymap.set('n', '<leader>gN', '<cmd>GitGutterPrevHunk<CR>')
