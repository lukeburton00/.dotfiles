return {
    "A7Lavinraj/fyler.nvim",
    opts = {
        views = {
            confirm = {
                win = {
                    border = "rounded",
                },
            },
            explorer = {
                default_explorer = true,
                indentscope = {
                    marker = "",
                },
                win = {
                    border = "rounded",
                    win_opts = {
                        number = false,
                        relativenumber = false,
                    },
                },
            },
        },
    },
    keys = {
        { "-", "<cmd>Fyler<cr>", desc = "Fyler" },
    },
}
