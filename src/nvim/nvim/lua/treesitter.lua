local configs = require'nvim-treesitter.configs'
configs.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc", "swift" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}
