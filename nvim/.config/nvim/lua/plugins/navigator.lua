return {
    "numtostr/navigator.nvim",
    cond = vim.env.HERDR_ENV ~= "1",
    opts = {},
    keys = {
        {
            "<C-h>",
            "<cmd>NavigatorLeft<CR>",
            mode = { "n", "t" },
        },
        {
            "<C-j>",
            "<cmd>NavigatorDown<CR>",
            mode = { "n", "t" },
        },
        {
            "<C-k>",
            "<cmd>NavigatorUp<CR>",
            mode = { "n", "t" },
        },
        {
            "<C-l>",
            "<cmd>NavigatorRight<CR>",
            mode = { "n", "t" },
        },
    },
}
