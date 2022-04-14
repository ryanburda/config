vim.cmd([[
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

let g:tmux_navigator_no_mappings = 1

" vim-tmux-runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

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

" colors
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
]])
