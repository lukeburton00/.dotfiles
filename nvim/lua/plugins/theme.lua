return {
    "topazape/oldtale.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("oldtale").setup({
            integrations = {
                blink = true,
                gitsigns = true,
                lsp = true,
                treesitter = true,
            },
        })
        vim.cmd("colorscheme oldtale")
    end,
}
