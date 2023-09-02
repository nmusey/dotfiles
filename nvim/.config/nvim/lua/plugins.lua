local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

packer.startup(function(use)
	use 'wbthomason/packer.nvim'

	-- Theming
	use 'morhetz/gruvbox'
	use 'sainnhe/everforest'
    use 'rebelot/kanagawa.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'dundalek/lazy-lsp.nvim'
    use {'williamboman/mason.nvim', run = ':MasonUpdate'}
    use 'williamboman/mason-lspconfig.nvim'
    use 'github/copilot.vim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
      requires = 'nvim-treesitter/nvim-treesitter',
    }

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'dcampos/nvim-snippy'
    use 'honza/vim-snippets'
    use 'dcampos/cmp-snippy'

	-- General
    use 'nvim-tree/nvim-web-devicons'
	use 'machakann/vim-highlightedyank'
	use 'preservim/nerdtree'
	use 'tpope/vim-commentary'
	use 'rstacruz/vim-closer'
    use 'akinsho/bufferline.nvim'
    use 'mbbill/undotree'
    use 'kylechui/nvim-surround'

    -- Debugging
    use 'mfussenegger/nvim-dap' -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation for installing clients

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    if packer_bootstrap then
        packer.sync()
    end
end)

require('plugins/autocomplete')
require('plugins/lsp')
require('plugins/treesitter')
require('plugins/telescope')
