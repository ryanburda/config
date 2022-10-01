local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("bde-airflow", { clear = true })

    local function keymaps()
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader> l',
            ':cexpr system("make lint | sed s#\\./#code/#")<cr>',
            { noremap=true, silent=false })
    end

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*/bde-airflow/**", },
        callback = keymaps,
        group = augroup
    })

end

return T
