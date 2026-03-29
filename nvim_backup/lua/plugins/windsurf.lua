return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "InsertEnter",

    keys = {
        {
            mode = "i",
            "<C-f>",
            function()
                require("codeium.virtual_text").cycle_or_complete()
            end,
            desc = "Codeium Complete",
        },
    },
    config = function()
        require("codeium").setup({
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                manual = true,
                key_bindings = {
                    accept = "<C-g>",
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                },
            },
        })
    end,
}
