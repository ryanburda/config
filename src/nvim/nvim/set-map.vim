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

let mapleader = " "
noremap <leader>w :w
noremap <leader>W :wq
noremap <leader>x :q
noremap <leader>X :q!

" these should match how tmux panes are created.
noremap <leader><cr> :split
noremap <leader>' :vsplit

" vim-tmux-navigator
" navigation is handled by <C-hjkl> no matter
" if it is a tmux pane or a vim split.
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
