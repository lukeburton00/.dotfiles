return {
    "mfussenegger/nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
        "rshkarin/mason-nvim-lint",
    },

    event = "BufReadPre",

    config = function()
        require("mason").setup()
        require("lint").linters_by_ft = {
            go = { "golangcilint" },
            c = { "cpplint" },
            cpp = { "cpplint" },
            python = { "ruff" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            eruby = { "erb_lint" },
            swift = { "swiftlint" },
        }

        require("mason-nvim-lint").setup({
            ignore_install = { "swiftlint" },
        })

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
