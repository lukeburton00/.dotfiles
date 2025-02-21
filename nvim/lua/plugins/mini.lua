return {
    'echasnovski/mini.nvim',
    version = '*',

    config = function ()
        -- Modules
        require("mini.ai").setup()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.pairs").setup()

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        require("mini.statusline").setup()
        require("mini.cursorword").setup()

        local starter = require "mini.starter"
        local hooks = {
            clear_statusline = function(buff)
                vim.opt_local.statusline = " "
                vim.cmd "highlight StatusLine ctermbg=None guibg=None"
                return buff
            end,

            local_keymap = function(buff)
                vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0 })
                vim.keymap.set("n", "j", "<cmd>normal <Down><cr>", { buffer = 0 })
                vim.keymap.set("n", "k", "<cmd>normal <Up><cr>", { buffer = 0 })
                return buff
            end,
        }

        starter.setup {
            autoopen = true,
            silent = true,
            evaluate_single = true,
            footer = "",

            items = {
                {
                    { name = "Find Files", action = "Telescope find_files", section = "" },
                    { name = "Live Grep", action = "Telescope live_grep", section = "" },
                    { name = "Yazi", action = function() require("yazi").yazi() end, section = "" },
                    { name = "Oil", action = function() require("oil").open() end, section = "" },
                    { name = "Git", action = function() require("lazygit").lazygit() end, section = "" },
                },
            },


            content_hooks = {
                starter.gen_hook.adding_bullet(" "),
                starter.gen_hook.aligning("center", "center"),
                hooks.clear_statusline,
                hooks.local_keymap,
            },

            query_updaters = "abcdefghilmnopqrstuvwxyz0123456789_-.",
        }
    end
}
