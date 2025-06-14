return {
    "stevearc/oil.nvim",
    lazy = false,

    keys = {
        { "<leader>-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },

    opts = {
        view_options = {
            show_hidden = true,
        },
    },
}
