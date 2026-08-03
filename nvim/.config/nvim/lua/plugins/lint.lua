return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            go = { "golangcilint" },
            ruby = { "rubocop" },
            nix = { "statix" },
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            cmake = { "cmake_lint" },
            rust = { "clippy" },
            typescript = { "eslint_d" },
            elixir = { "credo" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                vim.defer_fn(function()
                    require("lint").try_lint()
                end, 0)
            end,
        })
    end,
}
