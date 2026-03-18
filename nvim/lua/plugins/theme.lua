return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        background = {
            dark = "mocha",
        },
    },

    init = function()
        vim.cmd.colorscheme("catppuccin-nvim")
    end,
}
