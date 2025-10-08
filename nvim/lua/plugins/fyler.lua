return {
    "A7Lavinraj/fyler.nvim",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    keys = {
        {
            "-",
            "<cmd>Fyler<CR>",
            desc = "Fyler",
        },
    },
    opts = {
        win = {
            kind = "float",
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
}
