return {
    {
        'stevearc/oil.nvim',
        opts = {},

        lazy = false,

        config = function ()
            require("oil").setup {
                view_options = {
                    show_hidden = true
                },

                win_options = {
                    signcolumn = "yes:2",
                    statuscolumn = ""
                }
            }
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

        end
    },
    {
        ft = "oil",
        opts = {},   "FerretDetective/oil-git-signs.nvim",
    }
}
