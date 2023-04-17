local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  	package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

packer.startup(function(use)
	-- Theming
	use 'morhetz/gruvbox'
	use 'sainnhe/everforest'

	-- General
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-tree/nvim-web-devicons'
	use 'machakann/vim-highlightedyank'
	use 'preservim/nerdtree'
	use 'tpope/vim-commentary'
	use 'duane9/nvim-rg'
	use 'rstacruz/vim-closer'
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'ms-jpq/coq_nvim'

	-- Git
	use 'lewis6991/gitsigns.nvim'
	use 'Xuyuanp/nerdtree-git-plugin'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-fugitive'
  	end
)
