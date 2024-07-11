local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("bde-airflow", { clear = true })

    local function keymaps()

        -- lint
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader> l',
            ':cexpr system("docker compose exec -it af_scheduler /bin/bash -c \'flake8\'")<cr>',
            { noremap=true, silent=false }
        )

        -- force push to staging
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader> P',
            ':!git push -f origin $(git rev-parse --abbrev-ref HEAD):staging<cr>',
            { noremap=true, silent=false }
        )

    end

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*/bde-airflow/**", },
        callback = keymaps,
        group = augroup
    })

end

return T
