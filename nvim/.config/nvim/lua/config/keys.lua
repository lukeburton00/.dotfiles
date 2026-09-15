vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- LazyGit
vim.keymap.set("n", "<leader>g", function()
    local group = vim.api.nvim_create_augroup("LazyGitTermClose", {
        clear = true,
    })

    vim.api.nvim_create_autocmd("TermClose", {
        group = group,
        once = true,
        callback = function()
            vim.schedule(function()
                vim.api.nvim_feedkeys(vim.keycode("<CR>"), "n", false)
            end)
        end,
    })

    vim.cmd.term("lazygit")
    vim.cmd.startinsert()
end)
