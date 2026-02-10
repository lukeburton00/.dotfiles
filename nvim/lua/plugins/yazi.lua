return {
    "mikavilpas/yazi.nvim",
    lazy = false,
    keys = {
        {
            "-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open Yazi",
        },
    },
    opts = {
        open_for_directories = true,
    },
}
