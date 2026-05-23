-- Most keybinds are here but some plugin specifics are in the configuration file for that plugin.

-- Buffer Management
vim.keymap.set('n', '<leader>gv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>gs', '<cmd>split<CR>')
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")

-- Resize Windows
vim.keymap.set('n', '<M-h>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<M-l>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<M-j>', '<cmd>vertical resize -2<CR>')

-- Visual Mode
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Delete Settings
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>dd", [["_dd]])

vim.keymap.set("n", "y", '[["+Y]]')
vim.keymap.set("v", "p", "_dp")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- LSP & Diagnostics
vim.keymap.set('n', '<leader>fx', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>nn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next)

-- File tree
vim.keymap.set('n', '<leader>tt', '<cmd>Oil<CR>')

-- Git
vim.keymap.set('n', '<leader>hh', '<cmd>Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns reset_hunk<CR>')
vim.keymap.set('n', '<leader>hn', '<cmd>Gitsigns next_hunk<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns prev_hunk<CR>')

-- Ui tt
vim.keymap.set('n', '<leader>nd', '<cmd>Noice dismiss<CR>')
vim.keymap.set('n', '<leader>ns', '<cmd>Noice<CR>')
vim.keymap.set("c", "<C-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end)

