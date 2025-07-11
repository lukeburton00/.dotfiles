return {
    "mfussenegger/nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = "BufReadPre",
    config = function()
        require("lint").linters_by_ft = {
            go = { "golangcilint" },
            c = { "cpplint" },
            cpp = { "cpplint" },
            gdscript = { "gdlint" },
            python = { "ruff" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            ruby = { "rubocop" },
            eruby = { "erb_lint" },
            swift = { "swiftlint" },
            cmake = { "cmakelint" },
            yaml = { "yamllint" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
