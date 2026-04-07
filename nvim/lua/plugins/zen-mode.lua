vim.pack.add({
    { src = "https://github.com/folke/zen-mode.nvim" },
})

vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle()
end)
