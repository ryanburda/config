local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("finance-datamart", { clear = true })

    local function keymaps()

        -- lint
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader> l',
            ':cexpr system("docker compose exec -it dev /bin/bash -c \'flake8\'")<cr>',
            { noremap=true, silent=false }
        )

    end

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*/finance-datamart/**", },
        callback = keymaps,
        group = augroup
    })

end

return T
