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

    " ---
    " Git
    " ---
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'ruifm/gitlinker.nvim'

    " -------
    " Buffers
    " -------
    Plug 'bling/vim-bufferline'

    " -----
    " Notes
    " -----
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-notes'

call plug#end()

filetype plugin on

set nowrap
set number
set relativenumber
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cc=120
set ignorecase
set showmatch
set incsearch
set hlsearch
set mouse=v
set mouse=a
set clipboard=unnamedplus
set whichwrap+=<,>,h,l,[,]
set timeoutlen=2000
set formatoptions-=cro  " Don't continue comments on new line

" Close all buffers but current one.
command! BufOnly execute '%bdelete|edit #|normal `"'

map Y yy

nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

nnoremap <leader>w :w<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>Q :bd!<cr>
nnoremap <leader>0 :BufOnly<cr>
nnoremap <leader>x :q<cr>
nnoremap <leader>X :q!<cr>
nnoremap <leader>j :bnext<cr>
nnoremap <leader>k :bprevious<cr>
nnoremap <leader>i :tabprevious<cr>
nnoremap <leader>o :tabnext<cr>
nnoremap <leader>t :tab split<cr>
nnoremap <leader>v V
nnoremap <leader>V {v}
nnoremap <leader>a :let @/=expand("%:t") <Bar> execute 'Explore' expand("%:h") <Bar> normal n<cr>
nnoremap <leader>/ :source $MYVIMRC<cr>

" these should match how tmux panes are created.
nnoremap <leader>; :split<cr>
nnoremap <leader>' :vsplit<cr>
nnoremap <leader><C-h> :vertical resize -5<cr>
nnoremap <leader><C-j> :resize -5<cr>
nnoremap <leader><C-k> :vertical resize 5<cr>
nnoremap <leader><C-l> :resize 5<cr>

" vim-tmux-navigator
" navigation is handled by <C-hjkl> no matter if it is a tmux pane or a vim split.
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fd <cmd>lua require('telescope.builtin').find_files('~/Developer/')<cr>  " TODO: create function
"nnoremap <leader>fn <cmd>lua require('telescope.builtin').find_files('~/Developer/notes/')<cr>  " TODO: create function
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fD <cmd>lua require('telescope.builtin').live_grep('~/Developer/')<cr>  " TODO: create function
"nnoremap <leader>fN <cmd>lua require('telescope.builtin').live_grep('~/Developer/notes/')<cr>  " TODO: create function
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" harpoon
nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hh <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>

" vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>ei :VtrOpenRunner<cr>
xnoremap <leader>ee :VtrSendLinesToRunner<cr>
nnoremap <leader>ef :VtrSendFile<cr>

" vim-fugitive
nmap <leader>gs :G<cr>
nmap <leader>gd :Git diff<cr>
nmap <leader>gc :Git commit<cr>
nmap <leader>gp :Git push<cr>
" take diff left and diff right respectively
nmap <leader>gf :diffget //2<cr>
nmap <leader>gj :diffget //3<cr>

" gitlinker
nnoremap <leader>gl <cmd>lua require"gitlinker".get_buf_range_url("n")<cr>
nnoremap <leader>gw <cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>

" vim-airline
" remove the filetype part
let g:airline_section_x=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" bufferline
let g:airline#extensions#bufferline#overwrite_variables=0  " needed for some reason: https://github.com/bling/vim-bufferline/issues/27#issuecomment-68448978
let g:bufferline_active_buffer_left = '[ '
let g:bufferline_active_buffer_right = ']'
let g:bufferline_modified = '+ '
let g:bufferline_rotate = 2
let g:bufferline_inactive_highlight = 'StatusLine'
let g:bufferline_active_highlight = 'StatusLineNC'
let g:bufferline_solo_highlight = 1
let g:bufferline_show_bufnr = 0
let g:bufferline_echo = 0

" vim-notes
:let g:notes_directories = ['~/Developer/notes']

" Colors
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
