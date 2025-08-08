vim.g.mapleader = " "

-- all marks are global marks
local prefixes = "m'"
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #prefixes do
    local prefix = prefixes:sub(i, i)
    for j = 1, #letters do
        local lower_letter = letters:sub(j, j)
        local upper_letter = string.upper(lower_letter)
        vim.keymap.set({ "n", "v" }, prefix .. lower_letter, prefix .. upper_letter, { desc = "Mark " .. upper_letter })
    end
end

-- keep the cursor centered when making big jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>qo", vim.cmd.copen)
vim.keymap.set("n", "<leader>qc", vim.cmd.cclose)
