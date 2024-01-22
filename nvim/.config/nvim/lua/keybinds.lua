-- Most keybinds are here but some plugin specifics are in the configuration file for that plugin.

-- Tab Management
vim.keymap.set('n', '<leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader>T', '<cmd>tab split<CR>')
vim.keymap.set('n', 'J', '<cmd>tabp<CR>')
vim.keymap.set('n', 'K', '<cmd>tabn<CR>')
vim.keymap.set('n', '<leader>J', '<cmd>tabm -<CR>')
vim.keymap.set('n', '<leader>K', '<cmd>tabm +<CR>')

-- Buffer Management
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>qa", "<cmd>wqa!<CR>")
vim.keymap.set("n", "<leader>qo", "<cmd>tabo<CR>")

-- Pane Management
vim.keymap.set('', '<leader>V', '<cmd>vsplit<CR>')
vim.keymap.set('', '<leader>H', '<cmd>split<CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<A-h>', '5<C-w>>')
vim.keymap.set('n', '<A-j>', '5<C-w>-')
vim.keymap.set('n', '<A-k>', '5<C-w>+')
vim.keymap.set('n', '<A-l>', '5<C-w><')

-- Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank/Paste/Delete Settings
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>yy", [["+yy]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>dd", [["_dd]])

-- Navigation
vim.keymap.set('', '<leader>ft', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('', '<leader>ff', '<cmd>NERDTreeFocus<CR>')
vim.keymap.set('', '<leader>ffc', '<cmd>NERDTreeFind<CR>')

-- Telescope
local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s', telescope.find_files, {})
vim.keymap.set('n', '<leader>S', telescope.treesitter, {})
vim.keymap.set('n', '<leader>r', telescope.grep_string, {})

-- Git
vim.keymap.set('n', '<leader>gi', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>gb', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>GitGutterPreviewHunk<CR>')
vim.keymap.set('n', '<leader>hu', '<cmd>GitGutterUndoHunk<CR>')
vim.keymap.set('n', '<leader>hn', '<cmd>GitGutterNextHunk<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>GitGutterPrevHunk<CR>')

-- Copilot
vim.keymap.set('i', '<C-J>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-K>', '<Plug>(copilot-previous)')
