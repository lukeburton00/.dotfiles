vim.pack.add({
    { src = "https://github.com/A7Lavinraj/fyler.nvim" },
})

require("fyler").setup({
    views = {
        finder = {
            default_explorer = true,
        },
    },
})

vim.keymap.set("n", "<leader>e", function()
    require("fyler").toggle()
end, { desc = "Toggle file explorer" })
