return {
    "mikavilpas/yazi.nvim",

    keys = {
        {
            "<leader>y",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
    },

    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
        },
    },
}
