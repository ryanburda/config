if has('termguicolors')
    set termguicolors
endif

set background=dark

" Everforest theme.
" Installed via vim-plug.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
colorscheme everforest
