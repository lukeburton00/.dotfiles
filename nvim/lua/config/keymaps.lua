vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "Q", "<nop>")

-- center cursor after search and scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- lazygit
vim.keymap.set("n", "<leader>g", function()
    vim.cmd("vsplit | wincmd l | term lazygit")

    local buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_create_autocmd("TermClose", {
        buffer = buf,
        callback = function()
            vim.schedule(function()
                vim.cmd("bd!")
            end)
        end,
    })

    vim.cmd("startinsert")
end)

vim.keymap.set("n", "<leader>t", function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    vim.api.nvim_set_current_win(win)
                    vim.cmd.startinsert()
                    return
                end
            end
        end
    end

    vim.cmd("belowright 15split")
    vim.cmd("term")
    local buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_create_autocmd("TermClose", {
        buffer = buf,
        callback = function()
            vim.schedule(function()
                if vim.api.nvim_buf_is_loaded(buf) then
                    vim.cmd("bd!")
                end
            end)
        end,
    })

    vim.cmd.startinsert()
end)
