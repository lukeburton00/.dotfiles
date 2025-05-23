return {
    "rshkarin/mason-nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-lint",
    },

    event = "VeryLazy",

    config = function()
        require("lint").linters_by_ft = {
            go = { "golangcilint" },
            cpp = { "cpplint" },
            ruby = { "rubocop" },
        }

        require("mason-nvim-lint").setup({
            ignore_install = {
                'rubocop'
            }
        })

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
