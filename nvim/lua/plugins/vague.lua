return {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("vague").setup({
            bold = true,
            italic = true,
            transparent = false,
        })
    end,
}