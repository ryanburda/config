call plug#begin()

    " ------
    " Colors
    " ------
    Plug 'sainnhe/everforest'
    Plug 'sheerun/vim-polyglot'

    " ---------------
    " Code completion
    " ---------------
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " ---------------
    " File Navigation
    " ---------------
    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " Harpoon
    Plug 'ThePrimeagen/harpoon'

    " ---------------
    " Tmux
    " ---------------
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'christoomey/vim-tmux-runner'

call plug#end()
