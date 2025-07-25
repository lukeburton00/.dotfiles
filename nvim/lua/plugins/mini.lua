return {
    "echasnovski/mini.nvim",
    version = "*",
    event = "BufReadPre",
    keys = {
        {
            "-",
            function()
                -- open mini.files on current file
                require("mini.files").open(vim.api.nvim_buf_get_name(0))
            end,
            desc = "Toggle Mini Files",
        },
    },
    config = function()
        require("mini.ai").setup()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.pairs").setup()
        require("mini.diff").setup()

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        require("mini.statusline").setup()
        require("mini.cursorword").setup()

        require("mini.files").setup({
            windows = {
                preview = true,
            },
        })

        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
        })
    end,
}
