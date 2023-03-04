" ----- Plugins -----
call plug#begin()

" Theming
Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'MaxMEllon/vim-jsx-pretty'

" General extensions
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'duane9/nvim-rg'

" Autocompletion
Plug 'rstacruz/vim-closer'
Plug 'ms-jpq/coq_nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()
