vim.g.mapleader = ' '

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

-- LSP 
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    kim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
  end,
})

-- Telescope
telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>s', telescope.find_files, {})
vim.keymap.set('n', '<leader>S', telescope.treesitter, {})
vim.keymap.set('n', '<leader>r', telescope.grep_string, {})
vim.keymap.set('n', '<leader>R', telescope.git_files, {})

-- Git
vim.keymap.set('n', '<leader>g', '<cmd>GitGutterPreviewHunk<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>GitGutterNextHunk<CR>')
vim.keymap.set('n', '<leader>gN', '<cmd>GitGutterPrevHunk<CR>')
