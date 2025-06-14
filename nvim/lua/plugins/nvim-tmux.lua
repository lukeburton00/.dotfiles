return {
    "alexghergh/nvim-tmux-navigation",

    keys = {
        {
            "<C-h>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
            end,
            desc = "Tmux Navigate Left",
            mode = "n",
        },
        {
            "<C-j>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateDown()
            end,
            desc = "Tmux Navigate Down",
            mode = "n",
        },
        {
            "<C-k>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateUp()
            end,
            desc = "Tmux Navigate Up",
            mode = "n",
        },
        {
            "<C-l>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateRight()
            end,
            desc = "Tmux Navigate Right",
            mode = "n",
        },
        {
            "<C-\\>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateLastActive()
            end,
            desc = "Tmux Navigate Last Active",
            mode = "n",
        },
        {
            "<C-Space>",
            function()
                require("nvim-tmux-navigation").NvimTmuxNavigateNext()
            end,
            desc = "Tmux Navigate Next",
            mode = "n",
        },
    },

    opts = {
        disable_when_zoomed = true, -- defaults to false
    },
}
