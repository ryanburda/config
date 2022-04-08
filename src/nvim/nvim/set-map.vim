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

map Y yy

nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

noremap <leader>q :bd<cr>
noremap <leader>Q :bd!<cr>
noremap <leader>w :w<cr>
noremap <leader>j :bnext<cr>
noremap <leader>k :bprevious<cr>
noremap <leader>J :tabnext<cr>
noremap <leader>K :tabprevious<cr>
noremap <leader>t :tab split<cr>

" these should match how tmux panes are created.
noremap <leader>; :split<cr>
noremap <leader>' :vsplit<cr>
noremap <leader><C-h> :vertical resize -5<cr>
noremap <leader><C-j> :resize -5<cr>
noremap <leader><C-k> :vertical resize 5<cr>
noremap <leader><C-l> :resize 5<cr>

" vim-tmux-navigator
" navigation is handled by <C-hjkl> no matter
" if it is a tmux pane or a vim split.
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" harpoon
nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hh <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>

" vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>ri :VtrOpenRunner<cr>
nnoremap <leader>rf :VtrSendFile<cr>
xnoremap <leader>rl :VtrSendLinesToRunner<cr>

" Git
" vim-fugitive
" git status
nmap <leader>gs :G<cr>
" git diff
nmap <leader>gd :Git diff<cr>
" git commit
nmap <leader>gc :Git commit<cr>
" git push
nmap <leader>gp :Git push<cr>
" take diff left
nmap <leader>gf :diffget //2<cr>
" take diff right
nmap <leader>gj :diffget //3<cr>
" vim-airline
" remove the filetype part
let g:airline_section_x=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1
" gitlinker
" TODO: Maybe get rid of this in favor of vim-fugitive?
nnoremap <leader>gl <cmd>lua require"gitlinker".get_buf_range_url("n")<cr>
nnoremap <leader>gw <cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>

" bufferline
let g:airline#extensions#bufferline#overwrite_variables=0  " needed for some reason: https://github.com/bling/vim-bufferline/issues/27#issuecomment-68448978
let g:bufferline_active_buffer_left = '[ '
let g:bufferline_active_buffer_right = ']'
let g:bufferline_modified = '+ '
let g:bufferline_rotate = 1
let g:bufferline_inactive_highlight = 'StatusLine'
let g:bufferline_active_highlight = 'StatusLineNC'
let g:bufferline_solo_highlight = 1
let g:bufferline_show_bufnr = 0
let g:bufferline_echo = 0
