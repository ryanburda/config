local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require("packer").startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>pc', ':lua require("packer").compile()<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>pu', ':lua require("packer").update()<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ps', ':lua require("packer").sync()<cr>', opts)

    -- Color Schemes
    use "EdenEast/nightfox.nvim"
    -- Light
    -- vim.cmd('colorscheme dayfox')
    -- vim.cmd('set background=light')
    -- Dark
    vim.cmd('colorscheme nightfox')
    vim.cmd('set background=dark')

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'
    use {
        'lewis6991/spellsitter.nvim',
        config = require('plugins.configs.spellsitter').setup,
    }
    use {
        'https://codeberg.org/esensar/nvim-dev-container',
        config = require('plugins.configs.nvim-dev-container').setup,
    }
    use 'jamestthompson3/nvim-remote-containers'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            'freestingo/telescope-changed-files',
        },
        config = require('plugins.configs.telescope').setup
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = require('plugins.configs.gitsigns').setup
    }
    use {
        'ruifm/gitlinker.nvim',
        config = require('plugins.configs.gitlinker').setup
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = require('plugins.configs.diffview').setup
    }

    -- File Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.configs.nvim-tree').setup
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = require('plugins.configs.vim-tmux-navigator').setup
    }
    use {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner').setup
    }

    -- Buffer tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.configs.bufferline').setup,
    }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = require('plugins.configs.lualine').setup
    }

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = require('plugins.configs.vim-browser-search').setup
    }

    -- Highlight all occurrences of word under cursor
    use {
        'RRethy/vim-illuminate',
        config = require('plugins.configs.vim-illuminate').setup
    }

    -- Motion
    use 'justinmk/vim-sneak'

    -- Indentation lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.configs.indent-blankline').setup
    }

    -- Lists contents of file in right side gutter
    use {
        'simrat39/symbols-outline.nvim',
        config = require('plugins.configs.symbols-outline').setup
    }

    -- Close buffers
    use {
        'kazhala/close-buffers.nvim',
        config = require('plugins.configs.close-buffers').setup
    }

    -- Buffer deletion without changing layout
    use {
        'famiu/bufdelete.nvim',
        config = require('plugins.configs.bufdelete').setup
    }

    --- Scrolling
    use {
        'dstein64/nvim-scrollview',  -- Scrollbar
    }
    use {
        'karb94/neoscroll.nvim',    -- Smooth scrolling
        config = require('plugins.configs.neoscroll').setup
    }

    -- Floating Terminal
    use {
        'akinsho/toggleterm.nvim',
        config = require("plugins.configs.toggleterm").setup
    }

    -- Golden Ratio splits
    use {
        'beauwilliams/focus.nvim',
        config = require("plugins.configs.focus").setup
    }

    use {
        'toppair/peek.nvim',
        run = 'deno task --quiet build:fast',
        config = require("plugins.configs.peek").setup
    }

    ----------------------------
    -- Package Manager: Mason --
    ----------------------------
    use {
        "williamboman/mason.nvim",
        config = require("plugins.configs.mason").setup,
        run = require("plugins.configs.mason").install_daps
    }
    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "hrsh7th/nvim-cmp",
        },
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'ray-x/lsp_signature.nvim',
            '~/Developer/src/nvim/plugins/lsp-status.nvim',
            'nanotee/sqls.nvim',
            'onsails/lspkind.nvim',
        },
        config = require('plugins.configs.nvim-cmp').setup
    }
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = require("plugins.configs.mason-lspconfig").setup
    }
    -- Debug
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = require('plugins.configs.nvim-dap').setup
    }
    use {
        'rcarriga/nvim-dap-ui',
        requries = {
            'mfussenegger/nvim-dap',
        },
        config = require("plugins.configs.nvim-dap-ui").setup
    }
    use {
        'theHamsta/nvim-dap-virtual-text',
        requries = {
            'mfussenegger/nvim-dap',
        },
        config = function() require("nvim-dap-virtual-text").setup() end
    }
    use {
        'mfussenegger/nvim-dap-python',
        requires = {
            'mfussenegger/nvim-dap',
        },
    }

    -- Github Copilot
    use {
        'zbirenbaum/copilot.lua',
        opt = true,  -- only turn it on when you need it.
        config = require('plugins.configs.copilot').setup,
        requires = {
            {
                'zbirenbaum/copilot-cmp',
                module = 'copilot_cmp',
            },
        }
    }
    require('plugins.configs.copilot').keymap()  -- Needs to outside of setup since plugin is optional.

    -- Project specific setup scripts
    require('projects.bde-airflow').setup()

end)
