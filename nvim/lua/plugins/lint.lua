vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint" },
})

require("lint").linters_by_ft = {
    go = { "golangcilint" },
    ruby = { "rubocop" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    callback = function()
        vim.defer_fn(function()
            require("lint").try_lint()
        end, 0)
    end,
})
