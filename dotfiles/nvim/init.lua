require('server').setup()

vim.wo.wrap = false
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- pumheight should always be 2 less than scrolloff.
-- pumheigth sets the number of results in nvim-cmp.
-- +2 accounts for the padding of the nvim-cmp floating window.
-- scrolloff determines how many blank rows are padded below the last actual line of the buffer when scrolling down.
-- This ensures that nvim-cmp always shows up below cursor even when scrolled to the bottom of the buffer.
vim.opt.pumheight = 6
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 12
vim.opt.cc = '120'
vim.opt.encoding = 'UTF-8'
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.showmatch = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 250
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = '›~'}
vim.opt.autoread = true
vim.opt.winbar = '%=%m %f'
vim.o.statuscolumn = "%s%4l %2r  "

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')
vim.keymap.set('', '<Space>', '<NOP>', { noremap = true, silent = true })

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }
vim.keymap.set('n', '<leader>t'      , ':tabnew<cr>'      , {desc = 'New Tab'})
vim.keymap.set('n', '<leader>x'      , ':tabclose<cr>'    , {desc = 'Close Tab'})
vim.keymap.set('n', '<leader><S-Tab>', ':tabprevious<cr>' , {desc = 'Previous Tab'})
vim.keymap.set('n', '<leader><Tab>'  , ':tabnext<cr>'     , {desc = 'Next Tab'})
vim.keymap.set('n', '<leader><C-j>'  , ':split<cr><C-w>j' , {desc = 'Horizontal split'})
vim.keymap.set('n', '<leader><C-l>'  , ':vsplit<cr><C-w>l', {desc = 'Vertical split'})
--vim.keymap.set('n', 'L'              , 'zLgm'             , {desc = 'horizontal scroll right'})
--vim.keymap.set('n', 'H'              , 'zHgm'             , {desc = 'horizontal scroll left'})
vim.keymap.set('n', 'n'              , 'nzz'              , {desc = 'next occurrence of search and center'})
vim.keymap.set('n', 'N'              , 'Nzz'              , {desc = 'previous occurrence of search and center'})
vim.keymap.set('n', '<leader>p'      , '"0p'              , {desc = 'paste from yank register'})
vim.keymap.set('n', '<leader>P'      , '"0P'              , {desc = 'paste from yank register'})
vim.keymap.set('n', '<leader>0'      , ':%bd|e#|bd#<cr>'  , {desc = 'Close all buffers except current'})
vim.keymap.set('n', '<leader>cn'     , ':s/ *, */\\r/g<cr>', {desc = 'Split comma separated value into new lines'})
vim.keymap.set('n', '<leader>m'      , ':!open -a "Google Chrome" %<cr><cr>', {desc = 'Open current file in browser'})
vim.keymap.set('n', '<leader>F'      , ":let @+=expand('%')<CR>", {desc = 'Copy relative file path to clipboard'})
vim.keymap.set('n', '<leader>A'      , ":let @+=expand('%:p')<CR>", {desc = 'Copy absolute file path to clipboard'})
vim.keymap.set('n', '<leader>D'      , ":let @+=expand('%:h')<CR>", {desc = 'Copy directory path to clipboard'})
vim.keymap.set('n', '<leader>ds'     , ":lua if vim.o.diff == false then vim.cmd('windo diffthis') else vim.cmd('windo diffoff') end<cr>", {desc = 'Toggle diff of current split'})

-- quick notes
vim.keymap.set('n', '<leader>N' , ':edit ~/Documents/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.keymap.set('n', '<leader>ej', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.keymap.set('n', '<leader>ek', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.keymap.set('n', '<leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>', {desc = 'Diagnostics: open float'})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>jd', vim.lsp.buf.definition, {desc = 'LSP: jump to definition', buffer = ev.buf})
        vim.keymap.set('n', '<leader>jD', vim.lsp.buf.declaration, {desc = 'LSP: jump to declaration', buffer = ev.buf})
        vim.keymap.set('n', '<leader>jt', vim.lsp.buf.type_definition, {desc = 'LSP: jump to type', buffer = ev.buf})
        vim.keymap.set('n', '<leader>jk', vim.lsp.buf.references, {desc = 'LSP: references kwickfix', buffer = ev.buf})
        vim.keymap.set('n', '<leader>jr', vim.lsp.buf.rename, {desc = 'LSP: rename', buffer = ev.buf})
        vim.keymap.set({'n', 'v'}, '<leader>ja', vim.lsp.buf.code_action, {desc = 'LSP: code action', buffer = ev.buf})
        vim.keymap.set('n', 'H', vim.lsp.buf.signature_help, {desc = 'LSP: signature help', buffer = ev.buf})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'LSP: Hover', buffer = ev.buf})
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, {desc = 'LSP: format', buffer = ev.buf})
    end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded"
    }
)

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
        focusable = false,
        scope = "line",
    },
})

require('quickfix').keymaps()

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(require("plugins"))

vim.keymap.set('n', '<leader>`' , ':Lazy profile<CR>', {desc = 'Plugin Manager'})

-- Project specific setup scripts
require('projects.bde-airflow').setup()
require('projects.finance-datamart').setup()
