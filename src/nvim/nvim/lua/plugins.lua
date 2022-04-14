vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colors
    use 'sainnhe/everforest'
    use 'sheerun/vim-polyglot'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip'

    -- File Navigation
    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    -- Harpoon
    use 'ThePrimeagen/harpoon'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'
    use 'christoomey/vim-tmux-runner'

    -- Git
    use 'tpope/vim-fugitive'
    use 'ruifm/gitlinker.nvim'

    -- Status line
    use 'bling/vim-bufferline'
    use 'vim-airline/vim-airline'

    -- Notes
    use 'xolox/vim-misc'
    use 'xolox/vim-notes'

    -- Local Development
    use '~/Developer/nvim/plugins/chtsh'

end)
