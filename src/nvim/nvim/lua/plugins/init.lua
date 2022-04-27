vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(function(use)

    -- neovim package manager
    use 'wbthomason/packer.nvim'

    -- Highlighting & Colors
    use 'nvim-treesitter/nvim-treesitter'
    use 'sainnhe/everforest'
    use '4513ECHO/vim-colors-hatsunemiku'

    -- Splits
    -- use 'beauwilliams/focus.nvim'  # TODO: get this to work with diffview
    use 'famiu/bufdelete.nvim'

    -- File explorer
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

    -- Greeter
    use 'goolord/alpha-nvim'

    -- Luasnip
    use 'L3MON4D3/LuaSnip'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ray-x/lsp_signature.nvim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'
    use 'christoomey/vim-tmux-runner'

    -- Git
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'ruifm/gitlinker.nvim'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Status line
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use 'nvim-lua/lsp-status.nvim'

    -- Web Search
    use 'voldikss/vim-browser-search'

    -- commands on top of the sqls lsp
    use 'nanotee/sqls.nvim'

    -- Local Development
    use '~/Developer/nvim/plugins/chtsh'

end)

require('plugins.configs.alpha')
require('plugins.configs.bufferline')
require('plugins.configs.chtsh')
require('plugins.configs.cmp')
-- require('plugins.configs.focus')
require('plugins.configs.git')
require('plugins.configs.lualine')
require('plugins.configs.nvim-tree')
require('plugins.configs.telescope')
require('plugins.configs.treesitter')
require('plugins.configs.vim-browser-search')
require('plugins.configs.vim-tmux-navigator')
require('plugins.configs.vim-tmux-runner')
