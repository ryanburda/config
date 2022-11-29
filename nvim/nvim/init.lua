vim.wo.wrap = false
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cc = '120'
vim.opt.encoding = 'UTF-8'
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.clipboard = 'unnamedplus'
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.list = false
vim.opt.listchars = { space = '⋅', tab = '›~', eol = '↵' }

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')

-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', '<leader><S-Tab>', ':tabprevious<cr>'         , opts)
vim.api.nvim_set_keymap('n', '<leader><Tab>'  , ':tabnext<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>/'      , ':source $MYVIMRC<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>J'      , ':split<cr><C-w>j'         , opts)
vim.api.nvim_set_keymap('n', '<leader>L'      , ':vsplit<cr><C-w>l'        , opts)
vim.api.nvim_set_keymap('n', 'L'              , 'zLgm'                     , opts)  -- horizontal scroll right
vim.api.nvim_set_keymap('n', 'H'              , 'zHgm'                     , opts)  -- horizontal scroll left
vim.api.nvim_set_keymap('n', '<leader>cl'     , ':set background=light<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cd'     , ':set background=dark<CR>' , opts)

vim.api.nvim_set_keymap('n', '<leader>u', ':e #<cr>'       , opts)  -- open last closed buffer
vim.api.nvim_set_keymap('n', '<leader>0', ':%bd|e#|bd#<cr>', opts)  -- close all buffers except current

-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Documents/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.api.nvim_set_keymap('n', '<leader>hh', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>hk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>hl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- :help quickfix
vim.cmd([[
function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction
]])

vim.api.nvim_set_keymap('n', '<leader>ko' , ':copen<CR>'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>kx' , ':cclose<CR>'                , opts)
vim.api.nvim_set_keymap('n', '<leader>kj' , ':cnext<CR>'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>kk' , ':cprev<CR>'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>kgg', ':cfirst<CR>'                , opts)
vim.api.nvim_set_keymap('n', '<leader>kG' , ':clast<CR>'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>ka' , ':call QuickFixOpenAll()<CR>', opts)  -- open all files in quickfix list
vim.api.nvim_set_keymap('n', '<leader>kc' , ':cexpr []<CR>'              , opts)  -- clear quickfix list

-- :help location-list
vim.api.nvim_set_keymap('n', '<leader>lo' , ':lopen<CR>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>lx' , ':lclose<CR>'  , opts)
vim.api.nvim_set_keymap('n', '<leader>lj' , ':lnext<CR>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>lk' , ':lprev<CR>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>lgg', ':lfirst<CR>'  , opts)
vim.api.nvim_set_keymap('n', '<leader>lG' , ':llast<CR>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>lc' , ':lexpr []<CR>', opts)  -- clear location-list

require('plugins')
