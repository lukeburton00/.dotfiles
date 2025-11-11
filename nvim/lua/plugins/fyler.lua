return {
    "A7Lavinraj/fyler.nvim",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    lazy = false,
    keys = {
        {
            "-",
            "<cmd>Fyler<CR>",
            desc = "Fyler",
        },
    },
    opts = {
        views = {
            finder = {
                default_explorer = true,
                win = {
                    kind = "replace",
                    border = "rounded",
                    win_opts = {
                        number = false,
                        relativenumber = false,
                    },
                },
                indentscope = {
                    enabled = false,
                },
            },
        },
    },
}
