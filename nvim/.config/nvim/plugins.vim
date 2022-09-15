" ----- Plugins -----
call plug#begin()

" Theming
Plug 'morhetz/gruvbox'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'StanAngeloff/php.vim'


" General extensions
Plug 'kyazdani42/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'

" Autocompletion
Plug 'rstacruz/vim-closer'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver']
