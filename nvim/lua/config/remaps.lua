vim.g.mapleader = ' '

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

-- delete without copy
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")

-- shift-u to redo
vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set("n", "<leader>qo", vim.cmd.copen)
vim.keymap.set("n", "<leader>qc", vim.cmd.cclose)
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>")

-- lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gws', vim.lsp.buf.workspace_symbol)
vim.keymap.set('n', 'gca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grf', vim.lsp.buf.references)
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'ghs', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gof', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)
