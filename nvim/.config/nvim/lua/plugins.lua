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

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])


local packer_bootstrap = ensure_packer()


local ok, packer = pcall(require, 'packer')
if not ok then
	return
end

packer.startup(function(use)
	use 'wbthomason/packer.nvim'

	-- Theming
	use 'morhetz/gruvbox'
	use 'sainnhe/everforest'
    use 'rebelot/kanagawa.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig' 
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
              -- LSP Support
              {'dundalek/lazy-lsp.nvim'},
              {'williamboman/mason.nvim'},
              {'williamboman/mason-lspconfig.nvim'},

              -- Autocompletion
              {'hrsh7th/nvim-cmp'},
              {'hrsh7th/cmp-buffer'},
              {'hrsh7th/cmp-path'},
              {'saadparwaiz1/cmp_luasnip'},
              {'hrsh7th/cmp-nvim-lsp'},
              {'hrsh7th/cmp-nvim-lua'},
        }
    }

	-- General
    use ({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-tree/nvim-web-devicons'
	use 'machakann/vim-highlightedyank'
	use 'preservim/nerdtree'
	use 'tpope/vim-commentary'
	use 'rstacruz/vim-closer'
    use 'akinsho/bufferline.nvim'
    use 'mbbill/undotree'
    use 'kylechui/nvim-surround'

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
