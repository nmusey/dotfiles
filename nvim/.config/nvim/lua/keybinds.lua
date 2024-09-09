-- Most keybinds are here but some plugin specifics are in the configuration file for that plugin.

-- Tab Management
vim.keymap.set('n', '<leader>ge', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader>gt', '<cmd>tab split<CR>')
vim.keymap.set('n', '<leader>gv', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>gh', '<cmd>split<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader>gp', '<cmd>tabprevious<CR>')

-- Buffer Management
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>qq", "<cmd>close<CR>")
vim.keymap.set("n", "<C-b>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-B>", "<cmd>bprevious<CR>")

-- Pane Management
vim.keymap.set('n', '<leader>V', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>H', '<cmd>split<CR>')

-- Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize Windows
vim.keymap.set('n', '<M-h>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<M-l>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<M-j>', '<cmd>vertical resize -2<CR>')

-- Visual Mode
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Yank/Paste/Delete Settings
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>yy", [["+yy]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>dd", [["_dd]])

-- File tree
vim.keymap.set('', '<leader>tt', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('', '<leader>tf', '<cmd>NvimTreeFocus<CR>')
vim.keymap.set('', '<leader>tc', '<cmd>NvimTreeFindFile<CR>')

-- Telescope
local telescope = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fi', telescope.treesitter, {})
vim.keymap.set('n', '<leader>fs', telescope.live_grep, {})
vim.keymap.set('n', '<leader>bb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fc', telescope.grep_string, {})
vim.keymap.set('n', '<leader>fm', telescope.marks, {})

-- Git
vim.keymap.set('n', '<leader>gi', '<cmd>Git<CR>')
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>')
vim.keymap.set('n', '<leader>hh', '<cmd>GitGutterPreviewHunk<CR>')
vim.keymap.set('n', '<leader>hu', '<cmd>GitGutterUndoHunk<CR>')
vim.keymap.set('n', '<leader>hn', '<cmd>GitGutterNextHunk<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>GitGutterPrevHunk<CR>')

vim.keymap.set('n', '<leader>nd', '<cmd>Noice dismiss<CR>')
vim.keymap.set('n', '<leader>ns', '<cmd>Noice<CR>')
vim.keymap.set("c", "<C-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end)

-- LSP
local on_attach = function(args)
    vim.diagnostic.config({
        virtual_text = true
    })

    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = args.bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {})
    vim.keymap.set('n', 'gr', telescope.lsp_references, {})
end

vim.keymap.set('n', '<leader>fx', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>nn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next)
