return {
    "lmilojevicc/herdr-splits.nvim",
    cond = vim.env.HERDR_ENV == "1",
    event = "VeryLazy",
    config = function()
        require("herdr-splits").setup()
    end,
    keys = {
        {
            "<C-h>",
            function()
                require("herdr-splits").move_cursor_left()
            end,
            desc = "Navigate left across Neovim and Herdr splits",
        },
        {
            "<C-j>",
            function()
                require("herdr-splits").move_cursor_down()
            end,
            desc = "Navigate down across Neovim and Herdr splits",
        },
        {
            "<C-k>",
            function()
                require("herdr-splits").move_cursor_up()
            end,
            desc = "Navigate up across Neovim and Herdr splits",
        },
        {
            "<C-l>",
            function()
                require("herdr-splits").move_cursor_right()
            end,
            desc = "Navigate right across Neovim and Herdr splits",
        },
    },
}
