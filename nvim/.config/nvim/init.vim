" ----- General Configuration -----
syntax on

" Indentation settings
set tabstop=4
set softtabstop=4
set expandtab
set smartindent
set shiftwidth=4

" Line numbers
set number
set numberwidth=4
" set relativenumber " I go back and forth on liking this.

" Navigation
set mouse=a
set scrolloff=32

" Searching
set ignorecase
set smartcase

" Miscellaneous
set clipboard=unnamedplus
set splitbelow splitright
set title

let g:python3_host_prog = '/usr/local/bin/python3.6'



" ----- Plugins -----
call plug#begin('~/.config/nvim/plugged')

" Theming
Plug 'morhetz/gruvbox'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" General extensions
Plug 'kyazdani42/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
Plug 'rstacruz/vim-closer'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()



" ----- Theme -----
set termguicolors

colorscheme gruvbox
set background=dark



" ----- Language support -----
set signcolumn=yes
